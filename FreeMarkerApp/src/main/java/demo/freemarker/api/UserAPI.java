/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package demo.freemarker.api;

import demo.freemarker.dao.UserDAO;
import demo.freemarker.dto.DoctorInfo;
import demo.freemarker.dto.UserRoleDTO;
import demo.freemarker.model.Role;
import demo.freemarker.model.User;
import itri.sstc.framework.core.api.API;
import itri.sstc.framework.core.database.IntIdDataEntity;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;

/**
 *
 * @author zhush
 */
public class UserAPI implements API {

    private final static UserAPI INSTANCE = new UserAPI();

    public final static UserAPI getInstance() {
        return INSTANCE;
    }

    @Override
    public String getName() {
        return "UserAPI";
    }

    @Override
    public String getVersion() {
        return "20250211.01";
    }

    @Override
    public String getDescription() {
        return "使用者 API";
    }

    public List<User> listUser() {
        try {
            List<User> output = new ArrayList<>();
            List<IntIdDataEntity> list = UserDAO.getInstance().findEntities();
            for (IntIdDataEntity entity : list) {
                output.add((User) entity);
            }
            return output;

        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public User getUser(long id) {
        try {
            return (User) UserDAO.getInstance().findEntity(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void createUser(User user) {
        try {
            UserDAO.getInstance().create(user);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void updateUser(User user) {
        try {
            UserDAO.getInstance().edit(user);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public void deleteUser(long id) {
        try {
            UserDAO.getInstance().destroy(id);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    @APIDefine(description = "依name取得資料")
    public List<User> listUserByName(String name) {
        return UserDAO.getInstance().findByUserName(name);
    }

    public User getUserByAccount(String account) {
        return UserDAO.getInstance().findByAccount(account);
    }

    /**
     * 判斷用戶是否為當天首次登入
     * 
     * @param userId 用戶ID
     * @return 如果是當天首次登入返回true，否則返回false
     */
    public boolean isFirstLoginOfDay(Long userId) {
        try {
            User user = getUser(userId);
            if (user == null) {
                return false;
            }
            
            // 如果用戶從未登入過，肯定是首次登入
            if (user.getLastLoginDate() == null) {
                return true;
            }
            
            // 將日期格式化為yyyyMMdd以進行比較
            Date today = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String todayStr = sdf.format(today);
            String lastLoginStr = sdf.format(user.getLastLoginDate());
            
            // 如果上次登入日期不是今天，則為當天首次登入
            return !todayStr.equals(lastLoginStr);
            
        } catch (Exception ex) {
            System.err.println("Error checking first login of day: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }
    
    /**
     * 更新用戶的最後登入日期為今天
     * 
     * @param userId 用戶ID
     * @return 操作是否成功
     */
    public boolean updateLastLoginDate(Long userId) {
        try {
            User user = getUser(userId);
            if (user == null) {
                return false;
            }
            
            user.setLastLoginDate(new Date());
            updateUser(user);
            return true;
        } catch (Exception ex) {
            System.err.println("Error updating last login date: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        }
    }

    public List<User> listUserByRole(String role) {
        try{
            return UserDAO.getInstance().listUserByRole(role);

        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public User getUserByEmail(String email) {
        try {
            return UserDAO.getInstance().findByEmail(email);
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    public UserRoleDTO getUserRoleDTO(User user) {
         List<Role> roles = RoleAPI.getInstance().listRolesByUserId(user.getId());
         return new UserRoleDTO(user, roles);
    }
    
    public UserRoleDTO getUserROleDTO(Long userId) {
        User user = UserAPI.getInstance().getUser(userId);
        List<Role> roles = RoleAPI.getInstance().listRolesByUserId(user.getId());
        return new UserRoleDTO(user, roles);
    }

    public List<Role> getRoles(Long userId) {
        try {
            List<Role> output = RoleAPI.getInstance().listRolesByUserId(userId);
            return output;
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
    
    public List<UserRoleDTO> listTherapist() {
        List<UserRoleDTO> output = new ArrayList<UserRoleDTO>();
        try {
            List<User> users = this.listUser(); // 確保 UserDAO 已經初始化
            for (User user : users) {
                UserRoleDTO urd = this.getUserRoleDTO(user);
                if (urd.getRoleAlias() != null && (urd.getRoleAlias().contains("DTX") || urd.getRoleAlias().equals("DOCTOR"))) {
                    output.add(urd);
                }
            }
            return output;

        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }

    public List<DoctorInfo> listDoctorInfo() {
        List<DoctorInfo> doctorInfoList = new ArrayList<>();
        try {
            List<UserRoleDTO> doctors = this.listTherapist();
            for (UserRoleDTO doctor : doctors) {
                DoctorInfo info = convertToDoctorInfo(doctor.getUser());
                doctorInfoList.add(info);
            }
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
        return doctorInfoList;
    }

   public DoctorInfo convertToDoctorInfo(User user) {
       DoctorInfo info = new DoctorInfo();
       info.setId(user.getId());
       info.setName(user.getUsername());
       info.setTelCell(user.getTelCell());
       info.setEmail(user.getEmail());
       info.setGender(user.getGender());
       info.setRole(UserAPI.getInstance().getRoleName(user.getId()));
       // 若有 clinic/department 資訊，可以改從 user.getClincName() 或其它欄位帶入
       info.setDepartment("");
       return info;
   }

    public String getRoleName(Long userId) {
        List<Role> roles = this.getRoles(userId);
        for(Role role: roles){
            if(role.getAlias().equals("ADMIN")){
                continue;
            } else {
                return role.getDescription();
            }
        }
        return null;
    }

    public String getRoleAlias(Long userId) {
        List<Role> roles = this.getRoles(userId);
        for(Role role: roles){
            if(role.getAlias().equals("ADMIN")){
                continue;
            } else {
                return role.getAlias();
            }
        }
        return null;
    }
}

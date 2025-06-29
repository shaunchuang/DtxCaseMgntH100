// Backbone.js 0.5.3
// (c) 2010 Jeremy Ashkenas, DocumentCloud Inc.
// Backbone may be freely distributed under the MIT license.
// For all details and documentation:
// http://documentcloud.github.com/backbone
(function () {
	var h = this,
	p = h.Backbone,
	e;
	e = typeof exports !== "undefined" ? exports : h.Backbone = {};
	e.VERSION = "0.5.3";
	var f = h._;
	if (!f && typeof require !== "undefined")
		f = require("underscore")._;
	var g = h.jQuery || h.Zepto;
	e.noConflict = function () {
		h.Backbone = p;
		return this
	};
	e.emulateHTTP = !1;
	e.emulateJSON = !1;
	e.Events = {
		bind: function (a, b, c) {
			var d = this._callbacks || (this._callbacks = {});
			(d[a] || (d[a] = [])).push([b, c]);
			return this
		},
		unbind: function (a, b) {
			var c;
			if (a) {
				if (c = this._callbacks)
					if (b) {
						c = c[a];
						if (!c)
							return this;
						for (var d =
								0, e = c.length; d < e; d++)
							if (c[d] && b === c[d][0]) {
								c[d] = null;
								break
							}
					} else
						c[a] = []
			} else
				this._callbacks = {};
			return this
		},
		trigger: function (a) {
			var b,
			c,
			d,
			e,
			f = 2;
			if (!(c = this._callbacks))
				return this;
			for (; f--; )
				if (b = f ? a : "all", b = c[b])
					for (var g = 0, h = b.length; g < h; g++)
						(d = b[g]) ? (e = f ? Array.prototype.slice.call(arguments, 1) : arguments, d[0].apply(d[1] || this, e)) : (b.splice(g, 1), g--, h--);
			return this
		}
	};
	e.Model = function (a, b) {
		var c;
		a || (a = {});
		if (c = this.defaults)
			f.isFunction(c) && (c = c.call(this)), a = f.extend({}, c, a);
		this.attributes = {};
		this._escapedAttributes = {};
		this.cid = f.uniqueId("c");
		this.set(a, {
			silent: !0
		});
		this._changed = !1;
		this._previousAttributes = f.clone(this.attributes);
		if (b && b.collection)
			this.collection = b.collection;
		this.initialize(a, b)
	};
	f.extend(e.Model.prototype, e.Events, {
		_previousAttributes: null,
		_changed: !1,
		idAttribute: "id",
		initialize: function () {},
		toJSON: function () {
			return f.clone(this.attributes)
		},
		get: function (a) {
			return this.attributes[a]
		},
		escape: function (a) {
			var b;
			if (b = this._escapedAttributes[a])
				return b;
			b = this.attributes[a];
			return this._escapedAttributes[a] = (b == null ? "" : "" + b).replace(/&(?!\w+;|#\d+;|#x[\da-f]+;)/gi, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#x27;").replace(/\//g, "&#x2F;")
		},
		has: function (a) {
			return this.attributes[a] != null
		},
		set: function (a, b) {
			b || (b = {});
			if (!a)
				return this;
			if (a.attributes)
				a = a.attributes;
			var c = this.attributes,
			d = this._escapedAttributes;
			if (!b.silent && this.validate && !this._performValidation(a, b))
				return !1;
			if (this.idAttribute in a)
				this.id = a[this.idAttribute];
			var e = this._changing;
			this._changing = !0;
			for (var g in a) {
				var h = a[g];
				if (!f.isEqual(c[g], h))
					c[g] = h, delete d[g], this._changed = !0, b.silent || this.trigger("change:" + g, this, h, b)
			}
			!e && !b.silent && this._changed && this.change(b);
			this._changing = !1;
			return this
		},
		unset: function (a, b) {
			if (!(a in this.attributes))
				return this;
			b || (b = {});
			var c = {};
			c[a] = void 0;
			if (!b.silent && this.validate && !this._performValidation(c, b))
				return !1;
			delete this.attributes[a];
			delete this._escapedAttributes[a];
			a == this.idAttribute && delete this.id;
			this._changed =
				!0;
			b.silent || (this.trigger("change:" + a, this, void 0, b), this.change(b));
			return this
		},
		clear: function (a) {
			a || (a = {});
			var b,
			c = this.attributes,
			d = {};
			for (b in c)
				d[b] = void 0;
			if (!a.silent && this.validate && !this._performValidation(d, a))
				return !1;
			this.attributes = {};
			this._escapedAttributes = {};
			this._changed = !0;
			if (!a.silent) {
				for (b in c)
					this.trigger("change:" + b, this, void 0, a);
				this.change(a)
			}
			return this
		},
		fetch: function (a) {
			a || (a = {});
			var b = this,
			c = a.success;
			a.success = function (d, e, f) {
				if (!b.set(b.parse(d, f), a))
					return !1;
				c &&
				c(b, d)
			};
			a.error = i(a.error, b, a);
			return (this.sync || e.sync).call(this, "read", this, a)
		},
		save: function (a, b) {
			b || (b = {});
			if (a && !this.set(a, b))
				return !1;
			var c = this,
			d = b.success;
			b.success = function (a, e, f) {
				if (!c.set(c.parse(a, f), b))
					return !1;
				d && d(c, a, f)
			};
			b.error = i(b.error, c, b);
			var f = this.isNew() ? "create" : "update";
			return (this.sync || e.sync).call(this, f, this, b)
		},
		destroy: function (a) {
			a || (a = {});
			if (this.isNew())
				return this.trigger("destroy", this, this.collection, a);
			var b = this,
			c = a.success;
			a.success = function (d) {
				b.trigger("destroy",
					b, b.collection, a);
				c && c(b, d)
			};
			a.error = i(a.error, b, a);
			return (this.sync || e.sync).call(this, "delete", this, a)
		},
		url: function () {
			var a = k(this.collection) || this.urlRoot || l();
			if (this.isNew())
				return a;
			return a + (a.charAt(a.length - 1) == "/" ? "" : "/") + encodeURIComponent(this.id)
		},
		parse: function (a) {
			return a
		},
		clone: function () {
			return new this.constructor(this)
		},
		isNew: function () {
			return this.id == null
		},
		change: function (a) {
			this.trigger("change", this, a);
			this._previousAttributes = f.clone(this.attributes);
			this._changed = !1
		},
		hasChanged: function (a) {
			if (a)
				return this._previousAttributes[a] !=
				this.attributes[a];
			return this._changed
		},
		changedAttributes: function (a) {
			a || (a = this.attributes);
			var b = this._previousAttributes,
			c = !1,
			d;
			for (d in a)
				f.isEqual(b[d], a[d]) || (c = c || {}, c[d] = a[d]);
			return c
		},
		previous: function (a) {
			if (!a || !this._previousAttributes)
				return null;
			return this._previousAttributes[a]
		},
		previousAttributes: function () {
			return f.clone(this._previousAttributes)
		},
		_performValidation: function (a, b) {
			var c = this.validate(a);
			if (c)
				return b.error ? b.error(this, c, b) : this.trigger("error", this, c, b), !1;
			return !0
		}
	});
	e.Collection = function (a, b) {
		b || (b = {});
		if (b.comparator)
			this.comparator = b.comparator;
		f.bindAll(this, "_onModelEvent", "_removeReference");
		this._reset();
		a && this.reset(a, {
			silent: !0
		});
		this.initialize.apply(this, arguments)
	};
	f.extend(e.Collection.prototype, e.Events, {
		model: e.Model,
		initialize: function () {},
		toJSON: function () {
			return this.map(function (a) {
				return a.toJSON()
			})
		},
		add: function (a, b) {
			if (f.isArray(a))
				for (var c = 0, d = a.length; c < d; c++)
					this._add(a[c], b);
			else
				this._add(a, b);
			return this
		},
		remove: function (a, b) {
			if (f.isArray(a))
				for (var c =
						0, d = a.length; c < d; c++)
					this._remove(a[c], b);
			else
				this._remove(a, b);
			return this
		},
		get: function (a) {
			if (a == null)
				return null;
			return this._byId[a.id != null ? a.id : a]
		},
		getByCid: function (a) {
			return a && this._byCid[a.cid || a]
		},
		at: function (a) {
			return this.models[a]
		},
		sort: function (a) {
			a || (a = {});
			if (!this.comparator)
				throw Error("Cannot sort a set without a comparator");
			this.models = this.sortBy(this.comparator);
			a.silent || this.trigger("reset", this, a);
			return this
		},
		pluck: function (a) {
			return f.map(this.models, function (b) {
				return b.get(a)
			})
		},
		reset: function (a, b) {
			a || (a = []);
			b || (b = {});
			this.each(this._removeReference);
			this._reset();
			this.add(a, {
				silent: !0
			});
			b.silent || this.trigger("reset", this, b);
			return this
		},
		fetch: function (a) {
			a || (a = {});
			var b = this,
			c = a.success;
			a.success = function (d, f, e) {
				b[a.add ? "add" : "reset"](b.parse(d, e), a);
				c && c(b, d)
			};
			a.error = i(a.error, b, a);
			return (this.sync || e.sync).call(this, "read", this, a)
		},
		create: function (a, b) {
			var c = this;
			b || (b = {});
			a = this._prepareModel(a, b);
			if (!a)
				return !1;
			var d = b.success;
			b.success = function (a, e, f) {
				c.add(a, b);
				d && d(a, e, f)
			};
			a.save(null, b);
			return a
		},
		parse: function (a) {
			return a
		},
		chain: function () {
			return f(this.models).chain()
		},
		_reset: function () {
			this.length = 0;
			this.models = [];
			this._byId = {};
			this._byCid = {}
		},
		_prepareModel: function (a, b) {
			if (a instanceof e.Model) {
				if (!a.collection)
					a.collection = this
			} else {
				var c = a;
				a = new this.model(c, {
						collection: this
					});
				a.validate && !a._performValidation(c, b) && (a = !1)
			}
			return a
		},
		_add: function (a, b) {
			b || (b = {});
			a = this._prepareModel(a, b);
			if (!a)
				return !1;
			var c = this.getByCid(a);
			if (c)
				throw Error(["Can't add the same model to a set twice",
						c.id]);
			this._byId[a.id] = a;
			this._byCid[a.cid] = a;
			this.models.splice(b.at != null ? b.at : this.comparator ? this.sortedIndex(a, this.comparator) : this.length, 0, a);
			a.bind("all", this._onModelEvent);
			this.length++;
			b.silent || a.trigger("add", a, this, b);
			return a
		},
		_remove: function (a, b) {
			b || (b = {});
			a = this.getByCid(a) || this.get(a);
			if (!a)
				return null;
			delete this._byId[a.id];
			delete this._byCid[a.cid];
			this.models.splice(this.indexOf(a), 1);
			this.length--;
			b.silent || a.trigger("remove", a, this, b);
			this._removeReference(a);
			return a
		},
		_removeReference: function (a) {
			this == a.collection && delete a.collection;
			a.unbind("all", this._onModelEvent)
		},
		_onModelEvent: function (a, b, c, d) {
			(a == "add" || a == "remove") && c != this || (a == "destroy" && this._remove(b, d), b && a === "change:" + b.idAttribute && (delete this._byId[b.previous(b.idAttribute)], this._byId[b.id] = b), this.trigger.apply(this, arguments))
		}
	});
	f.each(["forEach", "each", "map", "reduce", "reduceRight", "find", "detect", "filter", "select", "reject", "every", "all", "some", "any", "include", "contains", "invoke", "max",
			"min", "sortBy", "sortedIndex", "toArray", "size", "first", "rest", "last", "without", "indexOf", "lastIndexOf", "isEmpty", "groupBy"], function (a) {
		e.Collection.prototype[a] = function () {
			return f[a].apply(f, [this.models].concat(f.toArray(arguments)))
		}
	});
	e.Router = function (a) {
		a || (a = {});
		if (a.routes)
			this.routes = a.routes;
		this._bindRoutes();
		this.initialize.apply(this, arguments)
	};
	var q = /:([\w\d]+)/g,
	r = /\*([\w\d]+)/g,
	s = /[-[\]{}()+?.,\\^$|#\s]/g;
	f.extend(e.Router.prototype, e.Events, {
		initialize: function () {},
		route: function (a,
			b, c) {
			e.history || (e.history = new e.History);
			f.isRegExp(a) || (a = this._routeToRegExp(a));
			e.history.route(a, f.bind(function (d) {
					d = this._extractParameters(a, d);
					c.apply(this, d);
					this.trigger.apply(this, ["route:" + b].concat(d))
				}, this))
		},
		navigate: function (a, b) {
			e.history.navigate(a, b)
		},
		_bindRoutes: function () {
			if (this.routes) {
				var a = [],
				b;
				for (b in this.routes)
					a.unshift([b, this.routes[b]]);
				b = 0;
				for (var c = a.length; b < c; b++)
					this.route(a[b][0], a[b][1], this[a[b][1]])
			}
		},
		_routeToRegExp: function (a) {
			a = a.replace(s, "\\$&").replace(q,
					"([^/]*)").replace(r, "(.*?)");
			return RegExp("^" + a + "$")
		},
		_extractParameters: function (a, b) {
			return a.exec(b).slice(1)
		}
	});
	e.History = function () {
		this.handlers = [];
		f.bindAll(this, "checkUrl")
	};
	var j = /^#*/,
	t = /msie [\w.]+/,
	m = !1;
	f.extend(e.History.prototype, {
		interval: 50,
		getFragment: function (a, b) {
			if (a == null)
				if (this._hasPushState || b) {
					a = window.location.pathname;
					var c = window.location.search;
					c && (a += c);
					a.indexOf(this.options.root) == 0 && (a = a.substr(this.options.root.length))
				} else
					a = window.location.hash;
			return decodeURIComponent(a.replace(j,
					""))
		},
		start: function (a) {
			if (m)
				throw Error("Backbone.history has already been started");
			this.options = f.extend({}, {
					root: "/"
				}, this.options, a);
			this._wantsPushState = !!this.options.pushState;
			this._hasPushState = !(!this.options.pushState || !window.history || !window.history.pushState);
			a = this.getFragment();
			var b = document.documentMode;
			if (b = t.exec(navigator.userAgent.toLowerCase()) && (!b || b <= 7))
				this.iframe = g('<iframe src="javascript:0" tabindex="-1" />').hide().appendTo("body")[0].contentWindow, this.navigate(a);
			this._hasPushState ? g(window).bind("popstate", this.checkUrl) : "onhashchange" in window && !b ? g(window).bind("hashchange", this.checkUrl) : setInterval(this.checkUrl, this.interval);
			this.fragment = a;
			m = !0;
			a = window.location;
			b = a.pathname == this.options.root;
			if (this._wantsPushState && !this._hasPushState && !b)
				return this.fragment = this.getFragment(null, !0), window.location.replace(this.options.root + "#" + this.fragment), !0;
			else if (this._wantsPushState && this._hasPushState && b && a.hash)
				this.fragment = a.hash.replace(j, ""), window.history.replaceState({},
					document.title, a.protocol + "//" + a.host + this.options.root + this.fragment);
			if (!this.options.silent)
				return this.loadUrl()
		},
		route: function (a, b) {
			this.handlers.unshift({
				route: a,
				callback: b
			})
		},
		checkUrl: function () {
			var a = this.getFragment();
			a == this.fragment && this.iframe && (a = this.getFragment(this.iframe.location.hash));
			if (a == this.fragment || a == decodeURIComponent(this.fragment))
				return !1;
			this.iframe && this.navigate(a);
			this.loadUrl() || this.loadUrl(window.location.hash)
		},
		loadUrl: function (a) {
			var b = this.fragment = this.getFragment(a);
			return f.any(this.handlers, function (a) {
				if (a.route.test(b))
					return a.callback(b), !0
			})
		},
		navigate: function (a, b) {
			var c = (a || "").replace(j, "");
			if (!(this.fragment == c || this.fragment == decodeURIComponent(c))) {
				if (this._hasPushState) {
					var d = window.location;
					c.indexOf(this.options.root) != 0 && (c = this.options.root + c);
					this.fragment = c;
					window.history.pushState({}, document.title, d.protocol + "//" + d.host + c)
				} else if (window.location.hash = this.fragment = c, this.iframe && c != this.getFragment(this.iframe.location.hash))
					this.iframe.document.open().close(),
					this.iframe.location.hash = c;
				b && this.loadUrl(a)
			}
		}
	});
	e.View = function (a) {
		this.cid = f.uniqueId("view");
		this._configure(a || {});
		this._ensureElement();
		this.delegateEvents();
		this.initialize.apply(this, arguments)
	};
	var u = /^(\S+)\s*(.*)$/,
	n = ["model", "collection", "el", "id", "attributes", "className", "tagName"];
	f.extend(e.View.prototype, e.Events, {
		tagName: "div",
		$: function (a) {
			return g(a, this.el)
		},
		initialize: function () {},
		render: function () {
			return this
		},
		remove: function () {
			g(this.el).remove();
			return this
		},
		make: function (a,
			b, c) {
			a = document.createElement(a);
			b && g(a).attr(b);
			c && g(a).html(c);
			return a
		},
		delegateEvents: function (a) {
			if (a || (a = this.events))
				for (var b in f.isFunction(a) && (a = a.call(this)), g(this.el).unbind(".delegateEvents" + this.cid), a) {
					var c = this[a[b]];
					if (!c)
						throw Error('Event "' + a[b] + '" does not exist');
					var d = b.match(u),
					e = d[1];
					d = d[2];
					c = f.bind(c, this);
					e += ".delegateEvents" + this.cid;
					d === "" ? g(this.el).bind(e, c) : g(this.el).delegate(d, e, c)
				}
		},
		_configure: function (a) {
			this.options && (a = f.extend({}, this.options, a));
			for (var b =
					0, c = n.length; b < c; b++) {
				var d = n[b];
				a[d] && (this[d] = a[d])
			}
			this.options = a
		},
		_ensureElement: function () {
			if (this.el) {
				if (f.isString(this.el))
					this.el = g(this.el).get(0)
			} else {
				var a = this.attributes || {};
				if (this.id)
					a.id = this.id;
				if (this.className)
					a["class"] = this.className;
				this.el = this.make(this.tagName, a)
			}
		}
	});
	e.Model.extend = e.Collection.extend = e.Router.extend = e.View.extend = function (a, b) {
		var c = v(this, a, b);
		c.extend = this.extend;
		return c
	};
	var w = {
		create: "POST",
		update: "PUT",
		"delete": "DELETE",
		read: "GET"
	};
	e.sync = function (a,
		b, c) {
		var d = w[a];
		c = f.extend({
				type: d,
				dataType: "json"
			}, c);
		if (!c.url)
			c.url = k(b) || l();
		if (!c.data && b && (a == "create" || a == "update"))
			c.contentType = "application/json", c.data = JSON.stringify(b.toJSON());
		if (e.emulateJSON)
			c.contentType = "application/x-www-form-urlencoded", c.data = c.data ? {
				model: c.data
			}
		 : {};
		if (e.emulateHTTP && (d === "PUT" || d === "DELETE")) {
			if (e.emulateJSON)
				c.data._method = d;
			c.type = "POST";
			c.beforeSend = function (a) {
				a.setRequestHeader("X-HTTP-Method-Override", d)
			}
		}
		if (c.type !== "GET" && !e.emulateJSON)
			c.processData =
				!1;
		return g.ajax(c)
	};
	var o = function () {},
	v = function (a, b, c) {
		var d;
		d = b && b.hasOwnProperty("constructor") ? b.constructor : function () {
			return a.apply(this, arguments)
		};
		f.extend(d, a);
		o.prototype = a.prototype;
		d.prototype = new o;
		b && f.extend(d.prototype, b);
		c && f.extend(d, c);
		d.prototype.constructor = d;
		d.__super__ = a.prototype;
		return d
	},
	k = function (a) {
		if (!a || !a.url)
			return null;
		return f.isFunction(a.url) ? a.url() : a.url
	},
	l = function () {
		throw Error('A "url" property or function must be specified');
	},
	i = function (a, b, c) {
		return function (d) {
			a ?
			a(b, d, c) : b.trigger("error", b, d, c)
		}
	}
}).call(this);
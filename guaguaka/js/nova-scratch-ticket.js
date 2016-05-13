(function() {
	(function() {
		(function(e, t) {
			if (typeof exports == "object") module.exports = t();
			else if (typeof define == "function" && define.amd) define("src/nova-scratch-ticket/main", [], t);
			else {
				var n = "__0",
					r = n.split("."),
					i = e;
				for (var s = 0; s < r.length - 1; s++) i[r[s]] === undefined && (i[r[s]] = {}), i = i[r[s]];
				i[r[r.length - 1]] = t()
			}
		})(this, function() {
			function e(e) {
				return {}[e]
			}
			var t = undefined;
			return NovaExports.__fixedUglify = "script>", NovaExports.exports = {
				stylesheet: ":host{display:block}"
			}, Nova.Components.NovaScratchTicket = NovaExports({
				is: "nova-scratch-ticket",
				"extends": "canvas",
				props: {
					img: String,
					color: {
						type: String,
						value: "rgba(0,0,0,0)"
					},
					fingerWidth: {
						type: Number,
						value: 30
					},
					threshold: {
						type: Number,
						value: .3
					}
				},
				createdHandler: function() {
					this.ele = this, this.$ele = $(this);
					var e = this.ele.getContext("2d");
					e.lineWidth = this.fingerWidth, e.lineCap = e.lineJoin = "round", e.strokeStyle = "black", this.ctx = e, this._eventEle = $({}), this._init()
				},
				_init: function() {
					this._drawImage(), this._bindEvents()
				},
				_drawImage: function() {
					var e = this,
						t = e.img,
						n, r = e.ele.width,
						i = e.ele.height;
					e.ctx.globalCompositeOperation = "source-over", e.ctx.fillStyle = e.color, e.ctx.fillRect(0, 0, r, i);
					if (!t) return;
					typeof t == "string" ? (n = new Image, n.crossOrigin = "*", n.onload = function() {
						e.ctx.drawImage(n, 0, 0, r, i), e._forceRepaint()
					}, n.src = t) : (n = t, e.ctx.drawImage(n, 0, 0, r, i)), e._forceRepaint()
				},
				_bindEvents: function() {
					function e(e) {
						e.preventDefault();
						var t = n._getCoors(e);
						n._scratchLine(t.x, t.y)
					}

					function t() {
						n.ctx.closePath();
						var i = n.getScratchRatio();
						i > n.threshold && !n.__scratched && (n.trigger("scratchoff"), n.__scratched = !0), r.off("touchmove", e), r.off("touchend", t)
					}
					var n = this,
						r = $("body");
					n.$ele.on("touchstart", function(i) {
						n.offset = n.$ele.offset();
						var s = n._getCoors(i);
						n._scratchLine(s.x, s.y, !0), r.on("touchmove", e), r.on("touchend", t)
					})
				},
				_scratchLine: function(e, t, n) {
					n && (this.ctx.globalCompositeOperation = "destination-out", this.ctx.beginPath(), this.ctx.moveTo(e + .01, t)), this.ctx.lineTo(e, t), this.ctx.stroke(), this._forceRepaint()
				},
				_getCoors: function(e) {
					var t, n = {},
						r = this.offset;
					return (t = e.changedTouches[0]) ? (n.pageX = t.pageX, n.pageY = t.pageY) : (n.pageX = e.pageX, n.pageY = e.pageY), {
						x: n.pageX - r.left,
						y: n.pageY - r.top
					}
				},
				_forceRepaint: function() {
					this.$ele.css("color") === "red" ? this.$ele.css("color", "black") : this.$ele.css("color", "red")
				},
				getScratchRatio: function() {
					var e = this.ctx.getImageData(0, 0, this.ele.width, this.ele.height),
						t = e.data,
						n = 4,
						r = t.length / 4,
						i = 0;
					for (var s = 0; s < t.length; s += n) t[s] != 0 && i++;
					return 1 - i / r
				},
				refresh: function() {
					this._drawImage(), this.__scratched = !1
				},
				clear: function() {
					this.ctx.globalCompositeOperation = "destination-out", this.ctx.fillStyle = "black", this.ctx.fillRect(0, 0, this.ele.width, this.ele.height), this.__scratched = !0, this._forceRepaint()
				}
			}), t
		})
	}).call(window)
})();
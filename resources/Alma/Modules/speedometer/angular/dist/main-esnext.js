(window["webpackJsonp"] = window["webpackJsonp"] || []).push([["main"], {

  /***/ 0:
  /*!***************************!*\
    !*** multi ./src/main.ts ***!
    \***************************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    module.exports = __webpack_require__(/*! D:\Impulsion\FXServer\resources\[baphomet]\baphomet\angular\src\main.ts */"zUnb");


    /***/
  }),

  /***/ "077Y":
  /*!**************************************************************!*\
    !*** ./src/app/pages/hungerthirst/hungerthirst.component.ts ***!
    \**************************************************************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    "use strict";

    Object.defineProperty(exports, "__esModule", {value: true});
    exports.HungerthirstComponent = void 0;
    const i0 = __webpack_require__(/*! @angular/core */ "fXoL");
    const i1 = __webpack_require__(/*! @angular/common */ "ofXK");
    const _c0 = function (a0) {
      return {"width.%": a0};
    };

    class HungerthirstComponent {
      constructor() {
        /**
         * Current player hunger value
         */
        this.hunger = 0;
        /**
         * Current player thirst value
         */
        this.thirst = 0;
        /**
         * If HUD is display or not
         */
        this.display = 2;
      }

      /**
       * Event handling to set vehicle speed
       * @param event
       */
      onMessageReceive(event) {
        if (event.data.hunger) {
          this.hunger = event.data.hunger;
        }
        if (event.data.thirst) {
          this.thirst = event.data.thirst;
        }
        if (event.data.display) {
          this.display = event.data.display;
        }
      }

      ngOnInit() {
      }
    }

    exports.HungerthirstComponent = HungerthirstComponent;
    HungerthirstComponent.ɵfac = function HungerthirstComponent_Factory(t) {
      return new (t || HungerthirstComponent)();
    };
    HungerthirstComponent.ɵcmp = i0.ɵɵdefineComponent({
      type: HungerthirstComponent,
      selectors: [["app-hungerthirst"]],
      hostBindings: function HungerthirstComponent_HostBindings(rf, ctx) {
        if (rf & 1) {
          i0.ɵɵlistener("message", function HungerthirstComponent_message_HostBindingHandler($event) {
            return ctx.onMessageReceive($event);
          }, false, i0.ɵɵresolveWindow);
        }
      },
      decls: 8,
      vars: 7,
      consts: [[1, "interface", 3, "hidden"], [1, "container"], [1, "type"], [1, "progress"], [1, "bar", "hunger", 3, "ngStyle"], [1, "bar", "thirst", 3, "ngStyle"]],
      template: function HungerthirstComponent_Template(rf, ctx) {
        if (rf & 1) {
          i0.ɵɵelementStart(0, "div", 0);
          i0.ɵɵelementStart(1, "div", 1);
          i0.ɵɵelementStart(2, "div", 2);
          i0.ɵɵelementStart(3, "div", 3);
          i0.ɵɵelement(4, "div", 4);
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementStart(5, "div", 2);
          i0.ɵɵelementStart(6, "div", 3);
          i0.ɵɵelement(7, "div", 5);
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
        }
        if (rf & 2) {
          i0.ɵɵproperty("hidden", ctx.display == 2);
          i0.ɵɵadvance(4);
          i0.ɵɵproperty("ngStyle", i0.ɵɵpureFunction1(3, _c0, ctx.hunger));
          i0.ɵɵadvance(3);
          i0.ɵɵproperty("ngStyle", i0.ɵɵpureFunction1(5, _c0, ctx.thirst));
        }
      },
      directives: [i1.NgStyle],
      styles: [".interface[_ngcontent-%COMP%] {\n  position: absolute;\n  top: 50px;\n  right: 90px;\n  width: 230px;\n}\n.interface[_ngcontent-%COMP%]   .container[_ngcontent-%COMP%] {\n  position: absolute;\n  right: -80px;\n  top: -35px;\n  width: 200px;\n  height: 53px;\n  box-sizing: border-box;\n  border-radius: 10px;\n}\n.interface[_ngcontent-%COMP%]   .container[_ngcontent-%COMP%]   .type[_ngcontent-%COMP%] {\n  width: 185px;\n  height: 12px;\n  margin: 5px 0;\n}\n.interface[_ngcontent-%COMP%]   .container[_ngcontent-%COMP%]   .type[_ngcontent-%COMP%]   .svg[_ngcontent-%COMP%] {\n  display: inline-block;\n  vertical-align: middle;\n  margin-right: -4px;\n  width: 14px;\n  text-align: center;\n}\n.interface[_ngcontent-%COMP%]   .container[_ngcontent-%COMP%]   .type[_ngcontent-%COMP%]   .progress[_ngcontent-%COMP%] {\n  display: inline-block;\n  vertical-align: middle;\n  margin-right: -4px;\n  margin-left: 8px;\n  width: calc(100% - 22px);\n  height: 7px;\n  background-color: rgba(187, 200, 222, 0.3);\n  border-radius: 10px;\n}\n.interface[_ngcontent-%COMP%]   .container[_ngcontent-%COMP%]   .type[_ngcontent-%COMP%]   .progress[_ngcontent-%COMP%]   .bar[_ngcontent-%COMP%] {\n  display: block;\n  height: 100%;\n  box-shadow: 4px 3px 3px #262626;\n  border-radius: 10px;\n}\n.interface[_ngcontent-%COMP%]   .container[_ngcontent-%COMP%]   .type[_ngcontent-%COMP%]   .progress[_ngcontent-%COMP%]   .bar.hunger[_ngcontent-%COMP%] {\n  background: #990f0f;\n  background: linear-gradient(164deg, #990f0f 5%, #df832d 48%);\n}\n.interface[_ngcontent-%COMP%]   .container[_ngcontent-%COMP%]   .type[_ngcontent-%COMP%]   .progress[_ngcontent-%COMP%]   .bar.thirst[_ngcontent-%COMP%] {\n  background: #09304a;\n  background: linear-gradient(164deg, #09304a 5%, #2d7edf 48%);\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uXFwuLlxcLi5cXC4uXFxodW5nZXJ0aGlyc3QuY29tcG9uZW50LnNjc3MiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7RUFDRSxrQkFBQTtFQUNBLFNBQUE7RUFDQSxXQUFBO0VBQ0EsWUFBQTtBQUNGO0FBRUU7RUFDRSxrQkFBQTtFQUNBLFlBQUE7RUFDQSxVQUFBO0VBQ0EsWUFBQTtFQUNBLFlBQUE7RUFDQSxzQkFBQTtFQUNBLG1CQUFBO0FBQUo7QUFFSTtFQUNFLFlBQUE7RUFDQSxZQUFBO0VBQ0EsYUFBQTtBQUFOO0FBRU07RUFDRSxxQkFBQTtFQUNBLHNCQUFBO0VBQ0Esa0JBQUE7RUFDQSxXQUFBO0VBQ0Esa0JBQUE7QUFBUjtBQUdNO0VBQ0UscUJBQUE7RUFDQSxzQkFBQTtFQUNBLGtCQUFBO0VBQ0EsZ0JBQUE7RUFDQSx3QkFBQTtFQUNBLFdBQUE7RUFDQSwwQ0FBQTtFQUNBLG1CQUFBO0FBRFI7QUFHUTtFQUNFLGNBQUE7RUFDQSxZQUFBO0VBQ0EsK0JBQUE7RUFDQSxtQkFBQTtBQURWO0FBR1U7RUFDRSxtQkFBQTtFQUNBLDREQUFBO0FBRFo7QUFJVTtFQUNFLG1CQUFBO0VBQ0EsNERBQUE7QUFGWiIsImZpbGUiOiJodW5nZXJ0aGlyc3QuY29tcG9uZW50LnNjc3MiLCJzb3VyY2VzQ29udGVudCI6WyIuaW50ZXJmYWNlIHtcclxuICBwb3NpdGlvbjogYWJzb2x1dGU7XHJcbiAgdG9wOiA1MHB4O1xyXG4gIHJpZ2h0OiA5MHB4O1xyXG4gIHdpZHRoOiAyMzBweDtcclxuXHJcblxyXG4gIC5jb250YWluZXIge1xyXG4gICAgcG9zaXRpb246IGFic29sdXRlO1xyXG4gICAgcmlnaHQ6IC04MHB4O1xyXG4gICAgdG9wOiAtMzVweDtcclxuICAgIHdpZHRoOiAyMDBweDtcclxuICAgIGhlaWdodDogNTNweDtcclxuICAgIGJveC1zaXppbmc6IGJvcmRlci1ib3g7XHJcbiAgICBib3JkZXItcmFkaXVzOiAxMHB4O1xyXG5cclxuICAgIC50eXBlIHtcclxuICAgICAgd2lkdGg6IDE4NXB4O1xyXG4gICAgICBoZWlnaHQ6IDEycHg7XHJcbiAgICAgIG1hcmdpbjogNXB4IDA7XHJcblxyXG4gICAgICAuc3ZnIHtcclxuICAgICAgICBkaXNwbGF5OiBpbmxpbmUtYmxvY2s7XHJcbiAgICAgICAgdmVydGljYWwtYWxpZ246IG1pZGRsZTtcclxuICAgICAgICBtYXJnaW4tcmlnaHQ6IC00cHg7XHJcbiAgICAgICAgd2lkdGg6IDE0cHg7XHJcbiAgICAgICAgdGV4dC1hbGlnbjogY2VudGVyO1xyXG4gICAgICB9XHJcblxyXG4gICAgICAucHJvZ3Jlc3Mge1xyXG4gICAgICAgIGRpc3BsYXk6IGlubGluZS1ibG9jaztcclxuICAgICAgICB2ZXJ0aWNhbC1hbGlnbjogbWlkZGxlO1xyXG4gICAgICAgIG1hcmdpbi1yaWdodDogLTRweDtcclxuICAgICAgICBtYXJnaW4tbGVmdDogOHB4O1xyXG4gICAgICAgIHdpZHRoOiBjYWxjKDEwMCUgLSAyMnB4KTtcclxuICAgICAgICBoZWlnaHQ6IDdweDtcclxuICAgICAgICBiYWNrZ3JvdW5kLWNvbG9yOiByZ2JhKCNCQkM4REUsIC4zKTtcclxuICAgICAgICBib3JkZXItcmFkaXVzOiAxMHB4O1xyXG5cclxuICAgICAgICAuYmFyIHtcclxuICAgICAgICAgIGRpc3BsYXk6IGJsb2NrO1xyXG4gICAgICAgICAgaGVpZ2h0OiAxMDAlO1xyXG4gICAgICAgICAgYm94LXNoYWRvdzogNHB4IDNweCAzcHggIzI2MjYyNjtcclxuICAgICAgICAgIGJvcmRlci1yYWRpdXM6IDEwcHg7XHJcblxyXG4gICAgICAgICAgJi5odW5nZXIge1xyXG4gICAgICAgICAgICBiYWNrZ3JvdW5kOiByZ2IoMTUzLCAxNSwgMTUpO1xyXG4gICAgICAgICAgICBiYWNrZ3JvdW5kOiBsaW5lYXItZ3JhZGllbnQoMTY0ZGVnLCByZ2JhKDE1MywgMTUsIDE1LCAxKSA1JSwgcmdiYSgyMjMsIDEzMSwgNDUsIDEpIDQ4JSk7XHJcbiAgICAgICAgICB9XHJcblxyXG4gICAgICAgICAgJi50aGlyc3Qge1xyXG4gICAgICAgICAgICBiYWNrZ3JvdW5kOiByZ2IoOSwgNDgsIDc0KTtcclxuICAgICAgICAgICAgYmFja2dyb3VuZDogbGluZWFyLWdyYWRpZW50KDE2NGRlZywgcmdiYSg5LCA0OCwgNzQsIDEpIDUlLCByZ2JhKDQ1LCAxMjYsIDIyMywgMSkgNDglKTtcclxuICAgICAgICAgIH1cclxuXHJcbiAgICAgICAgfVxyXG5cclxuICAgICAgfVxyXG5cclxuXHJcbiAgICB9XHJcbiAgfVxyXG5cclxufVxyXG4iXX0= */"]
    });


    /***/
  }),

  /***/ "3nAg":
  /*!*****************************************************************************!*\
    !*** ./src/app/components/spinner-component/spinner-component.component.ts ***!
    \*****************************************************************************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    "use strict";

    Object.defineProperty(exports, "__esModule", {value: true});
    exports.SpinnerComponentComponent = void 0;
    const i0 = __webpack_require__(/*! @angular/core */ "fXoL");

    class SpinnerComponentComponent {
      constructor() {
        this.value = 0;
        this.circumference = 2 * Math.PI * 47;
        this.strokeDashoffset = 0;
      }

      // tslint:disable-next-line:use-lifecycle-interface
      ngOnChanges(changes) {
        if (changes.value) {
          this.onPercentageChanged(changes.value.currentValue);
        }
      }

      onPercentageChanged(val) {
        this.strokeDashoffset = this.circumference - (val / 100) / 12 * this.circumference;
      }

      ngOnInit() {
      }
    }

    exports.SpinnerComponentComponent = SpinnerComponentComponent;
    SpinnerComponentComponent.ɵfac = function SpinnerComponentComponent_Factory(t) {
      return new (t || SpinnerComponentComponent)();
    };
    SpinnerComponentComponent.ɵcmp = i0.ɵɵdefineComponent({
      type: SpinnerComponentComponent,
      selectors: [["app-spinner-component"]],
      inputs: {value: "value"},
      features: [i0.ɵɵNgOnChangesFeature],
      decls: 8,
      vars: 4,
      consts: [["width", "50", "height", "50", 1, "circle"], ["stroke", "#FFFFFF", "stroke-width", "1.0", "fill", "transparent", "r", "18", "cx", "25", "cy", "25", "stroke-dasharray", "80 30", "stroke-dashoffset", "0", 1, "outer", 2, "stroke-opacity", "0.2"], ["stroke", "#FFFFFF", "stroke-width", "1.5", "fill", "transparent", "r", "18", "cx", "25", "cy", "25", "stroke-dasharray", "80 30", "stroke-dashoffset", "0", 1, "background", 2, "stroke-opacity", "0.2"], ["stroke", "url(#gradient)", "stroke-width", "2.5", "fill", "transparent", "r", "18", "cx", "25", "cy", "25", 1, "progress", 2, "stroke-opacity", "2"], ["id", "gradient"], ["offset", "30%", "stop-color", "#ff0000"], ["offset", "100%", "stop-color", "#ffc42d"]],
      template: function SpinnerComponentComponent_Template(rf, ctx) {
        if (rf & 1) {
          i0.ɵɵnamespaceSVG();
          i0.ɵɵelementStart(0, "svg", 0);
          i0.ɵɵelement(1, "circle", 1);
          i0.ɵɵelement(2, "circle", 2);
          i0.ɵɵelement(3, "circle", 3);
          i0.ɵɵelementStart(4, "defs");
          i0.ɵɵelementStart(5, "linearGradient", 4);
          i0.ɵɵelement(6, "stop", 5);
          i0.ɵɵelement(7, "stop", 6);
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
        }
        if (rf & 2) {
          i0.ɵɵadvance(3);
          i0.ɵɵstyleProp("stroke-dasharray", ctx.circumference)("stroke-dashoffset", ctx.strokeDashoffset);
        }
      },
      styles: [".background[_ngcontent-%COMP%], .outer[_ngcontent-%COMP%] {\n  transform: rotate(-220deg);\n  transform-origin: 50% 50%;\n}\n\n.progress[_ngcontent-%COMP%] {\n  transition: 0.35s stroke-dashoffset;\n  transform: rotate(130deg);\n  transform-origin: 50% 50%;\n}\n\nsvg[_ngcontent-%COMP%] {\n  opacity: 1;\n  position: absolute;\n  left: 50%;\n  top: 50%;\n  transform: scale(2) translate(-25%, -25%);\n}\n\n.outer[_ngcontent-%COMP%] {\n  opacity: 0.3;\n  transform: rotate(180deg) scale(1.2);\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uXFwuLlxcLi5cXC4uXFxzcGlubmVyLWNvbXBvbmVudC5jb21wb25lbnQuc2NzcyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtFQUNFLDBCQUFBO0VBQ0EseUJBQUE7QUFDRjs7QUFFQTtFQUNFLG1DQUFBO0VBRUEseUJBQUE7RUFDQSx5QkFBQTtBQUFGOztBQUlBO0VBQ0UsVUFBQTtFQUNBLGtCQUFBO0VBQ0EsU0FBQTtFQUNBLFFBQUE7RUFDQSx5Q0FBQTtBQURGOztBQUlBO0VBQ0UsWUFBQTtFQUNBLG9DQUFBO0FBREYiLCJmaWxlIjoic3Bpbm5lci1jb21wb25lbnQuY29tcG9uZW50LnNjc3MiLCJzb3VyY2VzQ29udGVudCI6WyIuYmFja2dyb3VuZCwgLm91dGVyIHtcclxuICB0cmFuc2Zvcm06IHJvdGF0ZSgtMjIwZGVnKTtcclxuICB0cmFuc2Zvcm0tb3JpZ2luOiA1MCUgNTAlO1xyXG59XHJcblxyXG4ucHJvZ3Jlc3Mge1xyXG4gIHRyYW5zaXRpb246IDAuMzVzIHN0cm9rZS1kYXNob2Zmc2V0O1xyXG4gIC8vIGF4aXMgY29tcGVuc2F0aW9uXHJcbiAgdHJhbnNmb3JtOiByb3RhdGUoMTMwZGVnKTtcclxuICB0cmFuc2Zvcm0tb3JpZ2luOiA1MCUgNTAlO1xyXG5cclxufVxyXG5cclxuc3ZnIHtcclxuICBvcGFjaXR5OiAxO1xyXG4gIHBvc2l0aW9uOiBhYnNvbHV0ZTtcclxuICBsZWZ0OiA1MCU7XHJcbiAgdG9wOiA1MCU7XHJcbiAgdHJhbnNmb3JtOiBzY2FsZSgyKSB0cmFuc2xhdGUoLTI1JSwgLTI1JSk7XHJcbn1cclxuXHJcbi5vdXRlciB7XHJcbiAgb3BhY2l0eTogLjM7XHJcbiAgdHJhbnNmb3JtOiByb3RhdGUoMTgwZGVnKSBzY2FsZSgxLjIpO1xyXG59XHJcbiJdfQ== */"]
    });


    /***/
  }),

  /***/ "8YFZ":
  /*!***************************************************************************************!*\
    !*** ./src/app/components/fuel-spinner-component/fuel-spinner-component.component.ts ***!
    \***************************************************************************************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    "use strict";

    Object.defineProperty(exports, "__esModule", {value: true});
    exports.FuelSpinnerComponentComponent = void 0;
    const i0 = __webpack_require__(/*! @angular/core */ "fXoL");

    class FuelSpinnerComponentComponent {
      constructor() {
        this.value = 0;
        this.color = "#FFF";
        this.background = "#FFF";
        this.circumference = 2 * Math.PI * 47;
        this.strokeDashoffset = 0;
      }

      ngOnInit() {
      }

      // tslint:disable-next-line:use-lifecycle-interface
      ngOnChanges(changes) {
        if (changes.value) {
          this.onPercentageChanged(changes.value.currentValue);
        }
      }

      onPercentageChanged(val) {
        this.strokeDashoffset = this.circumference - (val / 100) / 3.6 * this.circumference;
      }
    }

    exports.FuelSpinnerComponentComponent = FuelSpinnerComponentComponent;
    FuelSpinnerComponentComponent.ɵfac = function FuelSpinnerComponentComponent_Factory(t) {
      return new (t || FuelSpinnerComponentComponent)();
    };
    FuelSpinnerComponentComponent.ɵcmp = i0.ɵɵdefineComponent({
      type: FuelSpinnerComponentComponent,
      selectors: [["app-fuel-spinner-component"]],
      inputs: {value: "value", color: "color", background: "background"},
      features: [i0.ɵɵNgOnChangesFeature],
      decls: 7,
      vars: 8,
      consts: [["width", "40", "height", "40", 1, "circle"], ["stroke-width", "3", "fill", "transparent", "r", "18", "cx", "20", "cy", "20", "stroke-dasharray", "70 30", "stroke-dashoffset", "0", 1, "background", 2, "stroke-opacity", ".2"], ["stroke-width", "3", "fill", "transparent", "r", "18", "cx", "20", "cy", "20", 1, "progress", "progress-fuel", 2, "stroke-opacity", ".9"], ["id", "gradient"], ["offset", "30%", "stop-color", "#ffc53e"], ["offset", "100%", "stop-color", "#ffc53e"]],
      template: function FuelSpinnerComponentComponent_Template(rf, ctx) {
        if (rf & 1) {
          i0.ɵɵnamespaceSVG();
          i0.ɵɵelementStart(0, "svg", 0);
          i0.ɵɵelement(1, "circle", 1);
          i0.ɵɵelement(2, "circle", 2);
          i0.ɵɵelementStart(3, "defs");
          i0.ɵɵelementStart(4, "linearGradient", 3);
          i0.ɵɵelement(5, "stop", 4);
          i0.ɵɵelement(6, "stop", 5);
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
        }
        if (rf & 2) {
          i0.ɵɵadvance(1);
          i0.ɵɵstyleProp("stroke", ctx.background);
          i0.ɵɵadvance(1);
          i0.ɵɵstyleProp("stroke", ctx.color)("stroke-dasharray", ctx.circumference)("stroke-dashoffset", ctx.strokeDashoffset);
        }
      },
      styles: ["span[_ngcontent-%COMP%] {\n  color: rgba(255, 255, 255, 0.8);\n  font-size: 12px;\n  display: block;\n  margin-top: 0;\n}\n\nsvg[_ngcontent-%COMP%] {\n  opacity: 1 !important;\n}\n\n.background[_ngcontent-%COMP%], .outer[_ngcontent-%COMP%] {\n  transform: rotate(-220deg);\n  transform-origin: 50% 50%;\n}\n\n.progress[_ngcontent-%COMP%] {\n  transition: 0.35s stroke-dashoffset;\n  transform: rotate(99deg);\n  transform-origin: 50% 50%;\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uXFwuLlxcLi5cXC4uXFxmdWVsLXNwaW5uZXItY29tcG9uZW50LmNvbXBvbmVudC5zY3NzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0VBQ0UsK0JBQUE7RUFDQSxlQUFBO0VBQ0EsY0FBQTtFQUNBLGFBQUE7QUFDRjs7QUFFQTtFQUNFLHFCQUFBO0FBQ0Y7O0FBR0E7RUFDRSwwQkFBQTtFQUNBLHlCQUFBO0FBQUY7O0FBR0E7RUFDRSxtQ0FBQTtFQUNBLHdCQUFBO0VBQ0EseUJBQUE7QUFBRiIsImZpbGUiOiJmdWVsLXNwaW5uZXItY29tcG9uZW50LmNvbXBvbmVudC5zY3NzIiwic291cmNlc0NvbnRlbnQiOlsic3BhbiB7XHJcbiAgY29sb3I6IHJnYmEoMjU1LCAyNTUsIDI1NSwgLjgpO1xyXG4gIGZvbnQtc2l6ZTogMTJweDtcclxuICBkaXNwbGF5OiBibG9jaztcclxuICBtYXJnaW4tdG9wOiAwO1xyXG59XHJcblxyXG5zdmcge1xyXG4gIG9wYWNpdHk6IDEgIWltcG9ydGFudDtcclxufVxyXG5cclxuXHJcbi5iYWNrZ3JvdW5kLCAub3V0ZXIge1xyXG4gIHRyYW5zZm9ybTogcm90YXRlKC0yMjBkZWcpO1xyXG4gIHRyYW5zZm9ybS1vcmlnaW46IDUwJSA1MCU7XHJcbn1cclxuXHJcbi5wcm9ncmVzcyB7XHJcbiAgdHJhbnNpdGlvbjogMC4zNXMgc3Ryb2tlLWRhc2hvZmZzZXQ7XHJcbiAgdHJhbnNmb3JtOiByb3RhdGUoOTlkZWcpO1xyXG4gIHRyYW5zZm9ybS1vcmlnaW46IDUwJSA1MCU7XHJcbn1cclxuIl19 */"]
    });


    /***/
  }),

  /***/ "AytR":
  /*!*****************************************!*\
    !*** ./src/environments/environment.ts ***!
    \*****************************************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    "use strict";

// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.
    Object.defineProperty(exports, "__esModule", {value: true});
    exports.environment = void 0;
    exports.environment = {
      production: false
    };
    /*
     * For easier debugging in development mode, you can import the following file
     * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
     *
     * This import should be commented out in production mode because it will have a negative impact
     * on performance if an error is thrown.
     */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.


    /***/
  }),

  /***/ "FIw4":
  /*!****************************************************!*\
    !*** ./src/app/pages/default/default.component.ts ***!
    \****************************************************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    "use strict";

    Object.defineProperty(exports, "__esModule", {value: true});
    exports.DefaultComponent = void 0;
    const i0 = __webpack_require__(/*! @angular/core */ "fXoL");
    const i1 = __webpack_require__(/*! ../hungerthirst/hungerthirst.component */ "077Y");
    const i2 = __webpack_require__(/*! ../speedometer/speedometer.component */ "sGcO");

    class DefaultComponent {
      constructor() {
      }

      ngOnInit() {
      }
    }

    exports.DefaultComponent = DefaultComponent;
    DefaultComponent.ɵfac = function DefaultComponent_Factory(t) {
      return new (t || DefaultComponent)();
    };
    DefaultComponent.ɵcmp = i0.ɵɵdefineComponent({
      type: DefaultComponent,
      selectors: [["app-default"]],
      decls: 2,
      vars: 0,
      template: function DefaultComponent_Template(rf, ctx) {
        if (rf & 1) {
          i0.ɵɵelement(0, "app-hungerthirst");
          i0.ɵɵelement(1, "app-speedometer");
        }
      },
      directives: [i1.HungerthirstComponent, i2.SpeedometerComponent],
      styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJkZWZhdWx0LmNvbXBvbmVudC5zY3NzIn0= */"]
    });


    /***/
  }),

  /***/ "Sy1n":
  /*!**********************************!*\
    !*** ./src/app/app.component.ts ***!
    \**********************************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    "use strict";

    Object.defineProperty(exports, "__esModule", {value: true});
    exports.AppComponent = void 0;
    const i0 = __webpack_require__(/*! @angular/core */ "fXoL");
    const i1 = __webpack_require__(/*! @angular/router */ "tyNb");

    class AppComponent {
      constructor() {
        this.title = 'Riv-UI';
      }
    }

    exports.AppComponent = AppComponent;
    AppComponent.ɵfac = function AppComponent_Factory(t) {
      return new (t || AppComponent)();
    };
    AppComponent.ɵcmp = i0.ɵɵdefineComponent({
      type: AppComponent,
      selectors: [["app-root"]],
      decls: 1,
      vars: 0,
      template: function AppComponent_Template(rf, ctx) {
        if (rf & 1) {
          i0.ɵɵelement(0, "router-outlet");
        }
      },
      directives: [i1.RouterOutlet],
      styles: ["\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IiIsImZpbGUiOiJhcHAuY29tcG9uZW50LnNjc3MifQ== */"]
    });


    /***/
  }),

  /***/ "ZAI4":
  /*!*******************************!*\
    !*** ./src/app/app.module.ts ***!
    \*******************************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    "use strict";

    Object.defineProperty(exports, "__esModule", {value: true});
    exports.AppModule = void 0;
    const platform_browser_1 = __webpack_require__(/*! @angular/platform-browser */ "jhN1");
    const app_routing_module_1 = __webpack_require__(/*! ./app-routing.module */ "vY5A");
    const app_component_1 = __webpack_require__(/*! ./app.component */ "Sy1n");
    const default_component_1 = __webpack_require__(/*! ./pages/default/default.component */ "FIw4");
    const speedometer_component_1 = __webpack_require__(/*! ./pages/speedometer/speedometer.component */ "sGcO");
    const hungerthirst_component_1 = __webpack_require__(/*! ./pages/hungerthirst/hungerthirst.component */ "077Y");
    const spinner_component_component_1 = __webpack_require__(/*! ./components/spinner-component/spinner-component.component */ "3nAg");
    const fuel_spinner_component_component_1 = __webpack_require__(/*! ./components/fuel-spinner-component/fuel-spinner-component.component */ "8YFZ");
    const i0 = __webpack_require__(/*! @angular/core */ "fXoL");

    class AppModule {
    }

    exports.AppModule = AppModule;
    AppModule.ɵmod = i0.ɵɵdefineNgModule({type: AppModule, bootstrap: [app_component_1.AppComponent]});
    AppModule.ɵinj = i0.ɵɵdefineInjector({
      factory: function AppModule_Factory(t) {
        return new (t || AppModule)();
      }, providers: [], imports: [[
        platform_browser_1.BrowserModule,
        app_routing_module_1.AppRoutingModule,
      ]]
    });
    (function () {
      (typeof ngJitMode === "undefined" || ngJitMode) && i0.ɵɵsetNgModuleScope(AppModule, {
        declarations: [app_component_1.AppComponent,
          default_component_1.DefaultComponent,
          speedometer_component_1.SpeedometerComponent,
          hungerthirst_component_1.HungerthirstComponent,
          spinner_component_component_1.SpinnerComponentComponent,
          fuel_spinner_component_component_1.FuelSpinnerComponentComponent], imports: [platform_browser_1.BrowserModule,
          app_routing_module_1.AppRoutingModule]
      });
    })();


    /***/
  }),

  /***/ "sGcO":
  /*!************************************************************!*\
    !*** ./src/app/pages/speedometer/speedometer.component.ts ***!
    \************************************************************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    "use strict";

    Object.defineProperty(exports, "__esModule", {value: true});
    exports.SpeedometerComponent = void 0;
    const i0 = __webpack_require__(/*! @angular/core */ "fXoL");
    const i1 = __webpack_require__(/*! ../../components/spinner-component/spinner-component.component */ "3nAg");
    const i2 = __webpack_require__(/*! ../../components/fuel-spinner-component/fuel-spinner-component.component */ "8YFZ");
    const i3 = __webpack_require__(/*! @angular/common */ "ofXK");
    const _c0 = function (a0, a1) {
      return {"danger": a0, "warning": a1};
    };

    class SpeedometerComponent {
      constructor() {
        /**
         * Current vehicle speed.
         */
        this.speed = 0;
        /**
         * Current vehicle fuel.
         */
        this.fuel = 0;
        /**
         * Current nitro level
         */
        this.nitro = 0;
        /**
         * Display speedometer or not
         */
        this.speedometer = 2;
        /**
         * Display nitro bar
         */
        this.displayNitro = 2;
      }

      /**
       * Event handling to set vehicle speed
       * @param event
       */
      onMessageReceive(event) {
        if (event.data.speed) {
          this.speed = event.data.speed;
        }
        if (event.data.fuel) {
          this.fuel = event.data.fuel;
        }
        if (event.data.speedometer) {
          this.speedometer = event.data.speedometer;
        }
      }

      ngOnInit() {
      }
    }

    exports.SpeedometerComponent = SpeedometerComponent;
    SpeedometerComponent.ɵfac = function SpeedometerComponent_Factory(t) {
      return new (t || SpeedometerComponent)();
    };
    SpeedometerComponent.ɵcmp = i0.ɵɵdefineComponent({
      type: SpeedometerComponent,
      selectors: [["app-speedometer"]],
      hostBindings: function SpeedometerComponent_HostBindings(rf, ctx) {
        if (rf & 1) {
          i0.ɵɵlistener("message", function SpeedometerComponent_message_HostBindingHandler($event) {
            return ctx.onMessageReceive($event);
          }, false, i0.ɵɵresolveWindow);
        }
      },
      decls: 19,
      vars: 12,
      consts: [[1, "speedometer", 3, "hidden"], [1, "elements"], [1, "vehicle-speed"], [3, "value"], [1, "text"], [1, "speed"], [1, "kmh"], [1, "vehicle-fuel"], [1, "value", 3, "ngClass"], [1, "vehicle-nose", 3, "hidden"], ["color", "#256CE6", "background", "#8EB3F4", 3, "value"], [1, "value"]],
      template: function SpeedometerComponent_Template(rf, ctx) {
        if (rf & 1) {
          i0.ɵɵelementStart(0, "div", 0);
          i0.ɵɵelementStart(1, "div", 1);
          i0.ɵɵelementStart(2, "div", 2);
          i0.ɵɵelement(3, "app-spinner-component", 3);
          i0.ɵɵelementStart(4, "div", 4);
          i0.ɵɵelementStart(5, "span", 5);
          i0.ɵɵtext(6);
          i0.ɵɵelementEnd();
          i0.ɵɵelementStart(7, "div", 6);
          i0.ɵɵtext(8, "km/h");
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementStart(9, "div", 7);
          i0.ɵɵelement(10, "app-fuel-spinner-component", 3);
          i0.ɵɵelementStart(11, "div", 4);
          i0.ɵɵelementStart(12, "span", 8);
          i0.ɵɵtext(13);
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementStart(14, "div", 9);
          i0.ɵɵelement(15, "app-fuel-spinner-component", 10);
          i0.ɵɵelementStart(16, "div", 4);
          i0.ɵɵelementStart(17, "span", 11);
          i0.ɵɵtext(18);
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
          i0.ɵɵelementEnd();
        }
        if (rf & 2) {
          i0.ɵɵproperty("hidden", ctx.speedometer == 2);
          i0.ɵɵadvance(3);
          i0.ɵɵproperty("value", ctx.speed);
          i0.ɵɵadvance(3);
          i0.ɵɵtextInterpolate(ctx.speed);
          i0.ɵɵadvance(4);
          i0.ɵɵproperty("value", ctx.fuel);
          i0.ɵɵadvance(2);
          i0.ɵɵproperty("ngClass", i0.ɵɵpureFunction2(9, _c0, ctx.fuel >= 0 && ctx.fuel <= 5, ctx.fuel >= 6 && ctx.fuel <= 15));
          i0.ɵɵadvance(1);
          i0.ɵɵtextInterpolate(ctx.fuel);
          i0.ɵɵadvance(1);
          i0.ɵɵproperty("hidden", ctx.displayNitro == 2);
          i0.ɵɵadvance(1);
          i0.ɵɵproperty("value", ctx.nitro);
          i0.ɵɵadvance(3);
          i0.ɵɵtextInterpolate(ctx.nitro);
        }
      },
      directives: [i1.SpinnerComponentComponent, i2.FuelSpinnerComponentComponent, i3.NgClass],
      styles: [".speedometer[_ngcontent-%COMP%] {\n  height: 100%;\n  width: 100%;\n}\n.speedometer[_ngcontent-%COMP%]   .elements[_ngcontent-%COMP%] {\n  position: absolute;\n  bottom: 0;\n  left: 50%;\n  transform: translateX(-50%);\n}\n.speedometer[_ngcontent-%COMP%]   .elements[_ngcontent-%COMP%]   .vehicle-speed[_ngcontent-%COMP%] {\n  width: 100px;\n  height: 100px;\n  text-align: center;\n  -webkit-clip-path: polygon(100% 45%, 80% 45%, 60% 100%, 0% 100%, 0% 0%, 100% 0%);\n          clip-path: polygon(100% 45%, 80% 45%, 60% 100%, 0% 100%, 0% 0%, 100% 0%);\n}\n.speedometer[_ngcontent-%COMP%]   .elements[_ngcontent-%COMP%]   .vehicle-speed[_ngcontent-%COMP%]   svg[_ngcontent-%COMP%] {\n  opacity: 1;\n  position: absolute;\n  left: 50%;\n  top: 50%;\n  transform: scale(2) translate(-25%, -25%);\n}\n.speedometer[_ngcontent-%COMP%]   .elements[_ngcontent-%COMP%]   .vehicle-speed[_ngcontent-%COMP%]   .text[_ngcontent-%COMP%] {\n  width: 100%;\n  position: absolute;\n  top: 50%;\n  left: 52%;\n  transform: translate(-50%, -50%);\n  margin: 0;\n}\n.speedometer[_ngcontent-%COMP%]   .elements[_ngcontent-%COMP%]   .vehicle-speed[_ngcontent-%COMP%]   .text[_ngcontent-%COMP%]   .speed[_ngcontent-%COMP%] {\n  letter-spacing: 3px;\n  font-family: \"Big Shoulders Display\", cursive;\n  color: white;\n  font-size: 26px;\n  display: block;\n}\n.speedometer[_ngcontent-%COMP%]   .elements[_ngcontent-%COMP%]   .vehicle-speed[_ngcontent-%COMP%]   .text[_ngcontent-%COMP%]   .kmh[_ngcontent-%COMP%] {\n  color: rgba(255, 255, 255, 0.5);\n  font-size: 10px;\n  display: block;\n  text-transform: uppercase;\n}\n.speedometer[_ngcontent-%COMP%]   .vehicle-fuel[_ngcontent-%COMP%] {\n  transform: scale(0.7);\n  position: absolute;\n  bottom: -5px;\n  right: -5px;\n  text-align: center;\n  margin: 15px 0;\n}\n.speedometer[_ngcontent-%COMP%]   .vehicle-fuel[_ngcontent-%COMP%]   .text[_ngcontent-%COMP%] {\n  width: 100%;\n  position: absolute;\n  top: 45%;\n  left: 52%;\n  transform: translate(-50%, -50%);\n  margin: 0;\n}\n.speedometer[_ngcontent-%COMP%]   .vehicle-fuel[_ngcontent-%COMP%]   .text[_ngcontent-%COMP%]   .value[_ngcontent-%COMP%] {\n  letter-spacing: 1px;\n  font-family: \"Big Shoulders Display\", cursive;\n  color: white;\n  font-size: 20px;\n  display: block;\n}\n.speedometer[_ngcontent-%COMP%]   .vehicle-fuel[_ngcontent-%COMP%]   .text[_ngcontent-%COMP%]   .value.warning[_ngcontent-%COMP%] {\n  animation: warning-animation 1s step-start infinite !important;\n}\n.speedometer[_ngcontent-%COMP%]   .vehicle-fuel[_ngcontent-%COMP%]   .text[_ngcontent-%COMP%]   .value.danger[_ngcontent-%COMP%] {\n  animation: danger-animation 0.5s step-start infinite !important;\n}\n.speedometer[_ngcontent-%COMP%]   .vehicle-nose[_ngcontent-%COMP%] {\n  transform: scale(0.7);\n  position: absolute;\n  bottom: -5px;\n  right: -35px;\n  text-align: center;\n  margin: 15px 0;\n}\n.speedometer[_ngcontent-%COMP%]   .vehicle-nose[_ngcontent-%COMP%]   .text[_ngcontent-%COMP%] {\n  width: 100%;\n  position: absolute;\n  top: 45%;\n  left: 52%;\n  transform: translate(-50%, -50%);\n  margin: 0;\n}\n.speedometer[_ngcontent-%COMP%]   .vehicle-nose[_ngcontent-%COMP%]   .text[_ngcontent-%COMP%]   .value[_ngcontent-%COMP%] {\n  letter-spacing: 1px;\n  font-family: \"Big Shoulders Display\", cursive;\n  color: white;\n  font-size: 20px;\n  display: block;\n}\n/*# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uXFwuLlxcLi5cXC4uXFxzcGVlZG9tZXRlci5jb21wb25lbnQuc2NzcyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFBQTtFQUNFLFlBQUE7RUFDQSxXQUFBO0FBQ0Y7QUFDRTtFQUNFLGtCQUFBO0VBQ0EsU0FBQTtFQUNBLFNBQUE7RUFDQSwyQkFBQTtBQUNKO0FBQ0k7RUFDRSxZQUFBO0VBQ0EsYUFBQTtFQUNBLGtCQUFBO0VBQ0EsZ0ZBQUE7VUFBQSx3RUFBQTtBQUNOO0FBQ007RUFDRSxVQUFBO0VBQ0Esa0JBQUE7RUFDQSxTQUFBO0VBQ0EsUUFBQTtFQUNBLHlDQUFBO0FBQ1I7QUFFTTtFQUNFLFdBQUE7RUFDQSxrQkFBQTtFQUNBLFFBQUE7RUFDQSxTQUFBO0VBQ0EsZ0NBQUE7RUFDQSxTQUFBO0FBQVI7QUFFUTtFQUNFLG1CQUFBO0VBQ0EsNkNBQUE7RUFDQSxZQUFBO0VBQ0EsZUFBQTtFQUNBLGNBQUE7QUFBVjtBQUdRO0VBQ0UsK0JBQUE7RUFDQSxlQUFBO0VBQ0EsY0FBQTtFQUNBLHlCQUFBO0FBRFY7QUFPRTtFQUNFLHFCQUFBO0VBQ0Esa0JBQUE7RUFDQSxZQUFBO0VBQ0EsV0FBQTtFQUNBLGtCQUFBO0VBQ0EsY0FBQTtBQUxKO0FBT0k7RUFDRSxXQUFBO0VBQ0Esa0JBQUE7RUFDQSxRQUFBO0VBQ0EsU0FBQTtFQUNBLGdDQUFBO0VBQ0EsU0FBQTtBQUxOO0FBT007RUFDRSxtQkFBQTtFQUNBLDZDQUFBO0VBQ0EsWUFBQTtFQUNBLGVBQUE7RUFDQSxjQUFBO0FBTFI7QUFPUTtFQUNFLDhEQUFBO0FBTFY7QUFRUTtFQUNFLCtEQUFBO0FBTlY7QUFlRTtFQUNFLHFCQUFBO0VBQ0Esa0JBQUE7RUFDQSxZQUFBO0VBQ0EsWUFBQTtFQUNBLGtCQUFBO0VBQ0EsY0FBQTtBQWJKO0FBZUk7RUFDRSxXQUFBO0VBQ0Esa0JBQUE7RUFDQSxRQUFBO0VBQ0EsU0FBQTtFQUNBLGdDQUFBO0VBQ0EsU0FBQTtBQWJOO0FBZU07RUFDRSxtQkFBQTtFQUNBLDZDQUFBO0VBQ0EsWUFBQTtFQUNBLGVBQUE7RUFDQSxjQUFBO0FBYlIiLCJmaWxlIjoic3BlZWRvbWV0ZXIuY29tcG9uZW50LnNjc3MiLCJzb3VyY2VzQ29udGVudCI6WyIuc3BlZWRvbWV0ZXIge1xyXG4gIGhlaWdodDogMTAwJTtcclxuICB3aWR0aDogMTAwJTtcclxuXHJcbiAgLmVsZW1lbnRzIHtcclxuICAgIHBvc2l0aW9uOiBhYnNvbHV0ZTtcclxuICAgIGJvdHRvbTogMDtcclxuICAgIGxlZnQ6IDUwJTtcclxuICAgIHRyYW5zZm9ybTogdHJhbnNsYXRlWCgtNTAlKTtcclxuXHJcbiAgICAudmVoaWNsZS1zcGVlZCB7XHJcbiAgICAgIHdpZHRoOiAxMDBweDtcclxuICAgICAgaGVpZ2h0OiAxMDBweDtcclxuICAgICAgdGV4dC1hbGlnbjogY2VudGVyO1xyXG4gICAgICBjbGlwLXBhdGg6IHBvbHlnb24oMTAwJSA0NSUsIDgwJSA0NSUsIDYwJSAxMDAlLCAwJSAxMDAlLCAwJSAwJSwgMTAwJSAwJSk7XHJcblxyXG4gICAgICBzdmcge1xyXG4gICAgICAgIG9wYWNpdHk6IDE7XHJcbiAgICAgICAgcG9zaXRpb246IGFic29sdXRlO1xyXG4gICAgICAgIGxlZnQ6IDUwJTtcclxuICAgICAgICB0b3A6IDUwJTtcclxuICAgICAgICB0cmFuc2Zvcm06IHNjYWxlKDIpIHRyYW5zbGF0ZSgtMjUlLCAtMjUlKTtcclxuICAgICAgfVxyXG5cclxuICAgICAgLnRleHQge1xyXG4gICAgICAgIHdpZHRoOiAxMDAlO1xyXG4gICAgICAgIHBvc2l0aW9uOiBhYnNvbHV0ZTtcclxuICAgICAgICB0b3A6IDUwJTtcclxuICAgICAgICBsZWZ0OiA1MiU7XHJcbiAgICAgICAgdHJhbnNmb3JtOiB0cmFuc2xhdGUoLTUwJSwgLTUwJSk7XHJcbiAgICAgICAgbWFyZ2luOiAwO1xyXG5cclxuICAgICAgICAuc3BlZWQge1xyXG4gICAgICAgICAgbGV0dGVyLXNwYWNpbmc6IDNweDtcclxuICAgICAgICAgIGZvbnQtZmFtaWx5OiAnQmlnIFNob3VsZGVycyBEaXNwbGF5JywgY3Vyc2l2ZTtcclxuICAgICAgICAgIGNvbG9yOiByZ2JhKCNGRkZGRkYsIDEpO1xyXG4gICAgICAgICAgZm9udC1zaXplOiAyNnB4O1xyXG4gICAgICAgICAgZGlzcGxheTogYmxvY2s7XHJcbiAgICAgICAgfVxyXG5cclxuICAgICAgICAua21oIHtcclxuICAgICAgICAgIGNvbG9yOiByZ2JhKCNGRkZGRkYsIC41KTtcclxuICAgICAgICAgIGZvbnQtc2l6ZTogMTBweDtcclxuICAgICAgICAgIGRpc3BsYXk6IGJsb2NrO1xyXG4gICAgICAgICAgdGV4dC10cmFuc2Zvcm06IHVwcGVyY2FzZTtcclxuICAgICAgICB9XHJcbiAgICAgIH1cclxuICAgIH1cclxuICB9XHJcblxyXG4gIC52ZWhpY2xlLWZ1ZWwge1xyXG4gICAgdHJhbnNmb3JtOiBzY2FsZSguNyk7XHJcbiAgICBwb3NpdGlvbjogYWJzb2x1dGU7XHJcbiAgICBib3R0b206IC01cHg7XHJcbiAgICByaWdodDogLTVweDtcclxuICAgIHRleHQtYWxpZ246IGNlbnRlcjtcclxuICAgIG1hcmdpbjogMTVweCAwO1xyXG5cclxuICAgIC50ZXh0IHtcclxuICAgICAgd2lkdGg6IDEwMCU7XHJcbiAgICAgIHBvc2l0aW9uOiBhYnNvbHV0ZTtcclxuICAgICAgdG9wOiA0NSU7XHJcbiAgICAgIGxlZnQ6IDUyJTtcclxuICAgICAgdHJhbnNmb3JtOiB0cmFuc2xhdGUoLTUwJSwgLTUwJSk7XHJcbiAgICAgIG1hcmdpbjogMDtcclxuXHJcbiAgICAgIC52YWx1ZSB7XHJcbiAgICAgICAgbGV0dGVyLXNwYWNpbmc6IDFweDtcclxuICAgICAgICBmb250LWZhbWlseTogJ0JpZyBTaG91bGRlcnMgRGlzcGxheScsIGN1cnNpdmU7XHJcbiAgICAgICAgY29sb3I6IHJnYmEoI0ZGRkZGRiwgMSk7XHJcbiAgICAgICAgZm9udC1zaXplOiAyMHB4O1xyXG4gICAgICAgIGRpc3BsYXk6IGJsb2NrO1xyXG5cclxuICAgICAgICAmLndhcm5pbmcge1xyXG4gICAgICAgICAgYW5pbWF0aW9uOiB3YXJuaW5nLWFuaW1hdGlvbiAxcyBzdGVwLXN0YXJ0IGluZmluaXRlICFpbXBvcnRhbnQ7XHJcbiAgICAgICAgfVxyXG5cclxuICAgICAgICAmLmRhbmdlciB7XHJcbiAgICAgICAgICBhbmltYXRpb246IGRhbmdlci1hbmltYXRpb24gMC41cyBzdGVwLXN0YXJ0IGluZmluaXRlICFpbXBvcnRhbnQ7XHJcbiAgICAgICAgfVxyXG5cclxuICAgICAgfVxyXG5cclxuICAgIH1cclxuICB9XHJcblxyXG5cclxuICAudmVoaWNsZS1ub3NlIHtcclxuICAgIHRyYW5zZm9ybTogc2NhbGUoLjcpO1xyXG4gICAgcG9zaXRpb246IGFic29sdXRlO1xyXG4gICAgYm90dG9tOiAtNXB4O1xyXG4gICAgcmlnaHQ6IC0zNXB4O1xyXG4gICAgdGV4dC1hbGlnbjogY2VudGVyO1xyXG4gICAgbWFyZ2luOiAxNXB4IDA7XHJcblxyXG4gICAgLnRleHQge1xyXG4gICAgICB3aWR0aDogMTAwJTtcclxuICAgICAgcG9zaXRpb246IGFic29sdXRlO1xyXG4gICAgICB0b3A6IDQ1JTtcclxuICAgICAgbGVmdDogNTIlO1xyXG4gICAgICB0cmFuc2Zvcm06IHRyYW5zbGF0ZSgtNTAlLCAtNTAlKTtcclxuICAgICAgbWFyZ2luOiAwO1xyXG5cclxuICAgICAgLnZhbHVlIHtcclxuICAgICAgICBsZXR0ZXItc3BhY2luZzogMXB4O1xyXG4gICAgICAgIGZvbnQtZmFtaWx5OiAnQmlnIFNob3VsZGVycyBEaXNwbGF5JywgY3Vyc2l2ZTtcclxuICAgICAgICBjb2xvcjogcmdiYSgjRkZGRkZGLCAxKTtcclxuICAgICAgICBmb250LXNpemU6IDIwcHg7XHJcbiAgICAgICAgZGlzcGxheTogYmxvY2s7XHJcblxyXG5cclxuICAgICAgfVxyXG5cclxuICAgIH1cclxuICB9XHJcbn1cclxuXHJcblxyXG4iXX0= */"]
    });


    /***/
  }),

  /***/ "vY5A":
  /*!***************************************!*\
    !*** ./src/app/app-routing.module.ts ***!
    \***************************************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    "use strict";

    Object.defineProperty(exports, "__esModule", {value: true});
    exports.AppRoutingModule = void 0;
    const router_1 = __webpack_require__(/*! @angular/router */ "tyNb");
    const default_component_1 = __webpack_require__(/*! ./pages/default/default.component */ "FIw4");
    const i0 = __webpack_require__(/*! @angular/core */ "fXoL");
    const i1 = __webpack_require__(/*! @angular/router */ "tyNb");
    const routes = [
      {path: '**', redirectTo: 'angular/Riv-UI'},
      {path: 'angular/Riv-UI', component: default_component_1.DefaultComponent},
    ];

    class AppRoutingModule {
    }

    exports.AppRoutingModule = AppRoutingModule;
    AppRoutingModule.ɵmod = i0.ɵɵdefineNgModule({type: AppRoutingModule});
    AppRoutingModule.ɵinj = i0.ɵɵdefineInjector({
      factory: function AppRoutingModule_Factory(t) {
        return new (t || AppRoutingModule)();
      }, imports: [[router_1.RouterModule.forRoot(routes)], router_1.RouterModule]
    });
    (function () {
      (typeof ngJitMode === "undefined" || ngJitMode) && i0.ɵɵsetNgModuleScope(AppRoutingModule, {
        imports: [i1.RouterModule],
        exports: [router_1.RouterModule]
      });
    })();


    /***/
  }),

  /***/ "zUnb":
  /*!*********************!*\
    !*** ./src/main.ts ***!
    \*********************/
  /*! no static exports found */
  /***/ (function (module, exports, __webpack_require__) {

    "use strict";

    Object.defineProperty(exports, "__esModule", {value: true});
    const __NgCli_bootstrap_1 = __webpack_require__(/*! @angular/platform-browser */ "jhN1");
    const core_1 = __webpack_require__(/*! @angular/core */ "fXoL");
    const app_module_1 = __webpack_require__(/*! ./app/app.module */ "ZAI4");
    const environment_1 = __webpack_require__(/*! ./environments/environment */ "AytR");
    if (environment_1.environment.production) {
      core_1.enableProdMode();
    }
    __NgCli_bootstrap_1.platformBrowser().bootstrapModule(app_module_1.AppModule)
      .catch(err => console.error(err));


    /***/
  }),

  /***/ "zn8P":
  /*!******************************************************!*\
    !*** ./$$_lazy_route_resource lazy namespace object ***!
    \******************************************************/
  /*! no static exports found */
  /***/ (function (module, exports) {

    function webpackEmptyAsyncContext(req) {
      // Here Promise.resolve().then() is used instead of new Promise() to prevent
      // uncaught exception popping up in devtools
      return Promise.resolve().then(function () {
        var e = new Error("Cannot find module '" + req + "'");
        e.code = 'MODULE_NOT_FOUND';
        throw e;
      });
    }

    webpackEmptyAsyncContext.keys = function () {
      return [];
    };
    webpackEmptyAsyncContext.resolve = webpackEmptyAsyncContext;
    module.exports = webpackEmptyAsyncContext;
    webpackEmptyAsyncContext.id = "zn8P";

    /***/
  })

}, [[0, "runtime", "vendor"]]]);
//# sourceMappingURL=main-esnext.js.map

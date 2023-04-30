# urals-renderer-web-js


## Description
Functions for render web-element by template in browser by DOM with settings events after


## Requirements
Package tested for Haxe >= 4.0.
The functionality or it missing of the package for lesser versions has not been tested.

Only for js-browser target!


## Example of ClickMe SPA
```haxe
import urals.web.BrowserRenderer.browserRender;
import js.Browser;
import sneaker.assertion.Asserter.*;

class BrowserRendererTest 
{
    static var elems = [
        { id: 0, val: "Click me!" }
    ];

    static function setBodyNominal(): Void {
        Browser.document.body.outerHTML = '<body>'
            + '<ul></ul>'
            + '</body>';
    }

    static function getElements(): Array<{id: Int, val: String}> {
        return [
            { id: 1, val: "Click me!" }
        ];
    }

    static function rerender() {
        var renderId = (id: Int) -> 'li_' + Std.string(id);
        browserRender(
            elems,
            (el) -> "ul",
            { 
                template: (m: String, id: Int) -> '<li id="${renderId(id)}">${m}</li>',
                renderId: renderId 
            },
            (elHtml, el) -> {
                elHtml.onclick = (event) -> {
                    elems.push({id: elems.length, val: "Click me!"});
                    rerender();
                }
            }
        );
    }

    public static function run() {
        setBodyNominal();
        rerender();
    }
}
```


## Example of usage BrowserHtmlInjector class
```haxe
trace(Browser.document.body.outerHTML) 
//<body> 
//  <h1>Header</h1>
//  <div id="container">
//      <div class="elem">Text 1</div>
//      <div class="elem">Text 2</div>
//  </div>
//</body>

var injector = new BrowserHtmlInjector();
        var result = injector
            .append('.elem', '<h2>Preheader</h2>');
trace(result);
//<body>
//  <h1>Header</h1>
//  <div id="container">
//      <div class="elem">Text 1<h2>Preheader</h2></div>
//      <div class="elem">Text 2<h2>Preheader</h2></div>
//  </div>
//</body>
```


## Notice!
For SSR use package `urals-renderer-web`


## Author
Anatoly Starodubtsev
Tostar74@mail.ru
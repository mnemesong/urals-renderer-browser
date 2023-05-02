package urals.web;

import urals.web.BrowserRenderer;
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
        var rerenderer = new BrowserRenderer((elHtml, el) -> {
            elHtml.onclick = (event) -> {
                elems.push({id: elems.length, val: "Click me!"});
                rerender();
            }
        });
        rerenderer.render(
            elems,
            (el) -> "ul", { 
                template: (m: String, id: Int) -> '<li id="${renderId(id)}">${m}</li>',
                renderId: renderId 
        });
    }

    public static function run() {
        setBodyNominal();
        rerender();
        Browser.window.setTimeout(() -> {
            Browser.document.getElementById('li_0').click();
            assert(elems.length == 2);
        }, 50);
    }
}
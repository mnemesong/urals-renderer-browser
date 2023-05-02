package urals.web;

import js.Browser;
import js.html.Element;

class BrowserRenderer<M, Id> extends AbstractRenderer<M, Id> 
{
    private var afterRender: (elHtml: Element, el: {id: Id, val: M}) -> Void;

    public function new(
        afterRender: (elHtml: Element, el: {id: Id, val: M}) -> Void
    ) {
        this.afterRender = afterRender;
    }

    public function render(
        elements: Array<{id: Id, val: M}>, 
        getRootSelector: (el: {id: Id, val: M}) -> String,
        renderBundle: {
            template: (m: M, id: Id) -> String,
            renderId: (id: Id) -> String
        }
    ): BrowserRenderer<M, Id> {
        var doc = Browser.document;
        var group = AbstractRenderer.groupBySelector(elements, getRootSelector);
        for (i in 0...group.length) {
            var el = doc.querySelector(group[i].assoc);
            if(el != null) {
                el.innerHTML = group[i].arrs
                    .map(el -> renderBundle.template(el.val, el.id))
                    .join("\n");
            }
        }
        Browser.window.setTimeout(() -> {
            for (i in 0...elements.length) {
                var elHtml = doc.querySelector('#' + renderBundle.renderId(elements[i].id));
                if(elHtml != null) {
                    afterRender(elHtml, elements[i]);
                }
            }
        }, 10);
        return new BrowserRenderer(afterRender);
    }
}
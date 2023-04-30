package urals.web;

import js.html.Element;
import js.Browser;

class BrowserHtmlInjector implements HtmlInjectorInterface
{
    var parentNode: js.html.Element;

    public function new(?elem: Element = null) {
        parentNode = (elem == null)
            ? Browser.document.body
            : elem;
    }

    public function append(
        targetSelector: String, 
        elemHtml: String,
        onlyFirst: Bool = false
    ): HtmlInjectorInterface {
        var roots = (onlyFirst == false)
            ? [for (node in parentNode.querySelectorAll(targetSelector)) cast(node, Element)]
            : [parentNode.querySelector(targetSelector)];
        for (i in 0...roots.length) {
            var newElem = Browser.document.createElement('div');
            roots[i].append(newElem);
            newElem.outerHTML = elemHtml;
        }
        return this;
    }

    public function prepend(
        targetSelector: String,
        elemHtml: String,
        onlyFirst: Bool = false
    ): HtmlInjectorInterface {
        var roots = (onlyFirst == false)
            ? [for (node in parentNode.querySelectorAll(targetSelector)) cast(node, Element)]
            : [parentNode.querySelector(targetSelector)];
        for (i in 0...roots.length) {
            var newElem = Browser.document.createElement('div');
            roots[i].prepend(newElem);
            newElem.outerHTML = elemHtml;
        }
        return this;
    }

    public function replaceInnerhtml(
        targetSelector: String,
        elemHtml: String,
        onlyFirst: Bool = false
    ): HtmlInjectorInterface {
        var roots = (onlyFirst == false)
            ? [for (node in parentNode.querySelectorAll(targetSelector)) cast(node, Element)]
            : [parentNode.querySelector(targetSelector)];
        for (i in 0...roots.length) {
            var newElem = Browser.document.createElement('div');
            roots[i].innerHTML = elemHtml;
        }
        return this;
    }
}
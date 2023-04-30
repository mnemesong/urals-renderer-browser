package urals.web;

import js.Browser;
import urals.web.BrowserHtmlInjector;
import sneaker.assertion.Asserter.*;

class BrowserHtmlInjectorTest
{
    static function setBodyNominal(): Void {
        Browser.document.body.outerHTML = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem">Text 1</div>'
            + '<div class="elem">Text 2</div>'
            + '</div>'
            + '</body>';
    }

    static function testAppend1() {
        setBodyNominal();
        var injector = new BrowserHtmlInjector();
        var result = injector
            .append('.elem', '<h2>Preheader</h2>');
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem">Text 1<h2>Preheader</h2></div>'
            + '<div class="elem">Text 2<h2>Preheader</h2></div>'
            + '</div>'
            + '</body>';
        assert(Browser.document.body.outerHTML == nominal);
    }

    static function testAppend2() {
        setBodyNominal();
        var injector = new BrowserHtmlInjector();
        var result = injector
            .append('.elem', '<h2>Preheader</h2>', true);
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem">Text 1<h2>Preheader</h2></div>'
            + '<div class="elem">Text 2</div>'
            + '</div>'
            + '</body>';
        assert(Browser.document.body.outerHTML == nominal);
    }

    static function testPrepend1() {
        setBodyNominal();
        var injector = new BrowserHtmlInjector();
        var result = injector
            .prepend('.elem', '<h2>Preheader</h2>');
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem"><h2>Preheader</h2>Text 1</div>'
            + '<div class="elem"><h2>Preheader</h2>Text 2</div>'
            + '</div>'
            + '</body>';
        assert(Browser.document.body.outerHTML == nominal);
    }

    static function testPrepend2() {
        setBodyNominal();
        var injector = new BrowserHtmlInjector();
        var result = injector
            .prepend('.elem', '<h2>Preheader</h2>', true);
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem"><h2>Preheader</h2>Text 1</div>'
            + '<div class="elem">Text 2</div>'
            + '</div>'
            + '</body>';
        assert(Browser.document.body.outerHTML == nominal);
    }

    static function testInner1() {
        setBodyNominal();
        var injector = new BrowserHtmlInjector();
        var result = injector
            .replaceInnerhtml('.elem', '<h2>Preheader</h2>');
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem"><h2>Preheader</h2></div>'
            + '<div class="elem"><h2>Preheader</h2></div>'
            + '</div>'
            + '</body>';
        assert(Browser.document.body.outerHTML == nominal);
    }

    static function testInner2() {
        setBodyNominal();
        var injector = new BrowserHtmlInjector();
        var result = injector
            .replaceInnerhtml('.elem', '<h2>Preheader</h2>', true);
        var nominal = '<body>' 
            + '<h1>Header</h1>' 
            + '<div id="container">' 
            + '<div class="elem"><h2>Preheader</h2></div>'
            + '<div class="elem">Text 2</div>'
            + '</div>'
            + '</body>';
        assert(Browser.document.body.outerHTML == nominal);
    }

    public static function run() {
        testAppend1();
        testAppend2();
        testPrepend1();
        testPrepend2();
        testInner1();
        testInner2();
    }
}
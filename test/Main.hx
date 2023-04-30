package;

import urals.web.BrowserRendererTest;
import urals.web.BrowserHtmlInjectorTest;

class Main
{
    public static function main() {
        BrowserHtmlInjectorTest.run();
        BrowserRendererTest.run();
        trace("All tests had been successfully finished");
    }
}
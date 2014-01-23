#DSLOOSASS Architecture for Unlockable
**Domain Specific Language for Object Oriented Syntaticlly Awesome Stylesheets**

* Author: Jeff Scott Ward
* Twitter: @jeffscottward
* Github: jeffscottward

------

####Ruby Environment:  
Install the following Ruby Gems with: `gem install <module name>` in your Terminal App.

To learn the syntax and api, please use the documentation links 

* `gem install sass` - [Sass Docs](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html)
* `gem install compass` - [Compass Docs](http://compass-style.org/reference/compass/css3/)
* `gem install susy`  - [Susy Docs](http://susy.oddbird.net/guides/reference/)
* `gem install breakpoint` - [Breakpoint Docs](http://breakpoint-sass.com/)
* `gem install animation --pre` - [Animation Docs](https://github.com/ericam/compass-animation)

**Note: SUSY Grid was never used and may be removed by deleting the `@import` in `screen.sass` and deleting `base.sass`**

------
###Compiling Your SASS
* To watch for changes and fire-off the compilation process on save, type `compass watch` in the Terminal at the root of the client directory.

###Screen.sass (CSS Output file)
* This is the main file to which the all the imports are funneled into at the end of the compiling process.
* You will end up with a `screen.css` file.
* Prepended `_` files mean it does not compile that individual file

###App Baseline/Normalization
* Top section is just plugin setup
* Rest of files in `screen.sass` below
* `_vars.sass` - **ALL** Variables
* `_mixins.sass` - **ALL** Mixins (see [Sass Docs](http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html) for more on Mixins)
* `_fonts.sass` - **ALL** Typographic Fonts
* `_normalize.sass` - HTML5 Boilerplate [Normalize.css](https://github.com/necolas/normalize.css/)
* `_utils.sass` - HTML5 Boilerplate [Helpers](https://github.com/iaakash/HTML5Bolierplate/blob/master/doc/css.md)
* `animation/animate.* sass` - Required by Animation Plugin [no underscore because of compilation output](https://github.com/ericam/compass-animation#animatecss)
* `_custom-animations.sass` - Slider panel animation and sprite animation rule generators
* `_font-awesome.sass` - Only UI Font used so far. [Twitter Bootstrap's Font Awesome](http://fortawesome.github.io/Font-Awesome/)

------
###_Unlockable.sass (Main app file)

* `@import global-defaults` for baseline styling for the app

**Screen States**
Screen states are determined by HTML class chaining at the top of each file. 

* **Example:** `&.welcome-screen`
* **Example:** `&.instructions-screen`

#####NOTE:
The `&` symbol represents the css rule of the parent, and adding a class selector immediately following represents an **"iteration"** or **"modifying class"** of that rule.


**Initializer Screens**

* `@import '_welcome-screen'`
* `@import '_how-it-works-screen'`

**Instruction Screens**

* `@import '_instructions-template'` 
   * Abstracted baseline, applies to `[class*="-instructions-screen"]` (*e.g.* any class with that string)
* `@import '_trivia-instructions-screen'`
* `@import '_frames-instructions-screen'`
* `@import '_puzzle-instructions-screen'`

**Game Screens**

* `@import '_trivia-questions-screen'`
* `@import '_trivia-answers-screen'`
* `@import '_frames-round-screen'`
* `@import '_puzzle-game-screen'`

**End Screens**

* `@import '_complete-screen'`
* `@import '_goodbye-screen'`
* `@import '_error-screen'`

**Components** (Independent modules to be used though out the site)

* `@import '_unlockable-inner-modal'`
* `@import '_scroll-bars'`
* `@import '_robots'`
* `@import '_buttons'`
* `@import '_ui-elements'`

**Sprites**
###### [For usage of sprites click here](http://compass-style.org/help/tutorials/spriting/)

* Animation Sprite Imports
* Image(UI) Sprites Imports

***NOTE: Uncomment and save sprites to recompile, this is done to avoid image rebuilding on every save***

***NOTE: Not using/importing `_sprites.sass` but should be***
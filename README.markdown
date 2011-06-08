# Augmentations

*Augmentations* is a tiny Rails plugin to easily extend a model (or other class) with instance methods and class methods, as well as running class methods like `belongs_to` at extend time.

It's basically like `include`ing a module, but you can also define class methods and call class methods as you would in the class itself, without (ab)using the `self.included` hook and thus with less boilerplate.

Use it like

    class User < ActiveRecord::Base
      augment Shared::Pingable, User::PasswordResetExtension
    end

with modules like

    module User::PasswordResetExtension
      augmentation do

        has_many :password_resets

        def self.a_class_method
          # …
        end

        def an_instance_method
          # …
        end

      end
    end

This particular module would be found in `app/models/user/password_reset_extension.rb`.

(If you want to weird things up in the name of fewer lines of code, the Ruby parser will accept

    module User::PasswordResetExtension augmentation do

        …

    end end

too.)


## To-do

Add support for module arguments; something like

    augment Shared::Pingable, :pong => false

Should be possible with `class_exec` in Ruby 1.9.


## Credits and license

By [Henrik Nyh](http://henrik.nyh.se/) for [DanceJam](http://dancejam.com) under the MIT license:

>  Copyright (c) 2008 Henrik Nyh
>
>  Permission is hereby granted, free of charge, to any person obtaining a copy
>  of this software and associated documentation files (the "Software"), to deal
>  in the Software without restriction, including without limitation the rights
>  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>  copies of the Software, and to permit persons to whom the Software is
>  furnished to do so, subject to the following conditions:
>
>  The above copyright notice and this permission notice shall be included in
>  all copies or substantial portions of the Software.
>
>  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>  THE SOFTWARE.

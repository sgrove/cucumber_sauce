Run Cucumber tests cross-browser in parallel with Sauce Labs
============================================================
Installation
------------

    git clone http://github.com/sgrove/cucumber_sauce.git
    gem install cucumber selenium-client parallel
        
Config
------
Add your Sauce Labs username and api-key to ondemand.yml

Optionally edit one of the browser*.yml files to specify which browsers you want to run

Run
---

    rake cucumber_sauce

TODO
----
Combine all output into a single html report. Probably a long-term project.

Questions?
----------
Shoot me an email, I'm sean at saucelabs.com

Don't have a Sauce Labs accout?
Create an account and send me an email along with what you're working on, and I'll see if I can't get you a hundred minutes or so to test this out :)

Thanks
------
[Matt][1]

[Sauce Labs][2] (my employer and backend provider) 

License
-------
Released under MIT license

  [1]: http://wolfewebservices.com/blog/testing-multiple-browsers-selenium-and-cucumber
  [2]: http://saucelabs.com/
        

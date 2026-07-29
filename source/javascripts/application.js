//= require govuk_tech_docs

var tabsItemClass = 'app-tabs__item';
var tabsItemCurrentClass = tabsItemClass + '--current';
var tabsItemJsClass = 'js-tabs__item';
var headingItemClass = 'app-tabs__heading';
var headingItemCurrentClass = headingItemClass + '--current';
var headingItemJsClass = 'js-tabs__heading';
var headingItemJsLinkSelector = '.js-tabs__heading a';
var tabContainerHiddenClass = 'app-tabs__container--hidden';
var tabContainerJsClass = '.js-tabs__container';
var tabContainerNoTabsJsClass = 'js-tabs__container--no-tabs';
var allTabTogglers = '.' + tabsItemJsClass + ' a';
var tabTogglersMarkedOpenClass = '.js-tabs__item--open a';

function AppTabs ($module) {
    this.$module = $module;
    this.$allTabContainers = this.$module.querySelectorAll(tabContainerJsClass);
    this.$allTabTogglers = this.$module.querySelectorAll(allTabTogglers);
    this.$allTabTogglersMarkedOpen = this.$module.querySelectorAll(tabTogglersMarkedOpenClass);
    this.$mobileTabs = this.$module.querySelectorAll(headingItemJsLinkSelector);
}

AppTabs.prototype.init = function () {
    if (!this.$module) {
        return;
    }

    // Enhance tab links to buttons on mobile if JS enabled
    this.enhanceMobileButtons(this.$mobileTabs);

    // reset all tabs
    this.resetTabs();
    // add close to each tab
    this.$module.addEventListener('click', this.handleClick.bind(this));

    this.$allTabTogglersMarkedOpen.forEach(function ($tabToggler) {
        $tabToggler.click();
    });
};

AppTabs.prototype.activateAndToggle = function (event) {
    event.preventDefault();
    var $currentToggler = event.target;
    var $currentTogglerSiblings = this.$module.querySelectorAll('[aria-controls="' + $currentToggler.getAttribute('aria-controls') + '"]');
    var $tabContainer;

    try {
        $tabContainer = this.$module.querySelector('#' + $currentToggler.getAttribute('aria-controls'));
    } catch (exception) {
        throw new Error('Invalid example ID given: ' + exception);
    }
    var isTabAlreadyOpen = $currentToggler.getAttribute('aria-expanded') === 'true';

    if (!$tabContainer) {
        return;
    }

    if (isTabAlreadyOpen) {
        $tabContainer.classList.add(tabContainerHiddenClass);
        $tabContainer.setAttribute('aria-hidden', 'true');
        $currentTogglerSiblings.forEach(function ($tabToggler) {
            $tabToggler.setAttribute('aria-expanded', 'false');
            // desktop and mobile
            $tabToggler.parentNode.classList.remove(tabsItemCurrentClass, headingItemCurrentClass);
        });
    } else {
        // Reset tabs
        this.resetTabs();
        // make current active
        $tabContainer.classList.remove(tabContainerHiddenClass);
        $tabContainer.setAttribute('aria-hidden', 'false');

        $currentTogglerSiblings.forEach(function ($tabToggler) {
            $tabToggler.setAttribute('aria-expanded', 'true');
            if ($tabToggler.parentNode.classList.contains(tabsItemClass)) {
                $tabToggler.parentNode.classList.add(tabsItemCurrentClass);
            } else if ($tabToggler.parentNode.classList.contains(headingItemClass)) {
                $tabToggler.parentNode.classList.add(headingItemCurrentClass);
            }
        });
    }
};

// We progressively enhance the mobile tab links to buttons
// to make sure we're using semantic HTML to describe the behaviour of the tabs
AppTabs.prototype.enhanceMobileButtons = function (mobileTabs) {
    mobileTabs.forEach(function (mobileTab) {
        var button = document.createElement('button');
        button.setAttribute('aria-controls', mobileTab.getAttribute('aria-controls'));
        button.setAttribute('data-track', mobileTab.getAttribute('data-track'));
        button.classList.add('app-tabs__heading-button');
        button.innerHTML = mobileTab.innerHTML;
        mobileTab.parentNode.appendChild(button);
        mobileTab.parentNode.removeChild(mobileTab);
    });
    this.$allTabTogglers = this.$module.querySelectorAll(allTabTogglers);
};

// reset aria attributes to default and close the tab content container
AppTabs.prototype.resetTabs = function () {
    this.$allTabContainers.forEach(function ($tabContainer) {
        // unless the tab content has not tabs and it's been set as open
        if (!$tabContainer.classList.contains(tabContainerNoTabsJsClass)) {
            $tabContainer.classList.add(tabContainerHiddenClass);
            $tabContainer.setAttribute('aria-hidden', 'true');
        }
    });

    this.$allTabTogglers.forEach(function ($tabToggler) {
        $tabToggler.setAttribute('aria-expanded', 'false');
        // desktop and mobile
        $tabToggler.parentNode.classList.remove(tabsItemCurrentClass, headingItemCurrentClass);
    });
};

AppTabs.prototype.handleClick = function (event) {
    // toggle and active selected tab and heading (on mobile)
    if (event.target.parentNode.classList.contains(tabsItemJsClass) ||
        event.target.parentNode.classList.contains(headingItemJsClass)) {
        this.activateAndToggle(event);
    }
};

var $tabs = document.querySelectorAll('[data-module="app-tabs"]');
$tabs.forEach(function ($tabs) {
    new AppTabs($tabs).init();
});

function OnboardingNavigation ($module) {
    this.$module = $module;
    this.paths = [
        '/cloud-native-platform/onboarding/',
        '/cloud-native-platform/onboarding/person/',
        '/cloud-native-platform/onboarding/team/'
    ];
}

OnboardingNavigation.prototype.init = function () {
    if (!this.$module) {
        return;
    }

    this.paths.forEach(function (path) {
        this.enhanceItem(path);
    }, this);

    this.openCurrentBranch();
};

OnboardingNavigation.prototype.enhanceItem = function (path) {
    var $link = this.findLink(path);

    if (!$link || !$link.parentNode) {
        return;
    }

    var $item = $link.parentNode;
    var $list = this.findDirectList($item);

    if (!$list || $item.classList.contains('toc-nested-collapsible')) {
        return;
    }

    var id = 'toc-nested-' + path.replace(/^\/|\/$/g, '').replace(/\//g, '-');
    $list.id = $list.id || id;
    $list.classList.add('toc-nested-collapsible__body');
    $link.classList.add('toc-nested-collapsible__heading');
    $item.classList.add('toc-nested-collapsible');

    $link.insertAdjacentElement('afterend', this.buildButton($item, $link, $list.id));
};

OnboardingNavigation.prototype.buildButton = function ($item, $link, listId) {
    var $button = document.createElement('button');
    var $label = document.createElement('span');
    var $icon = document.createElement('span');

    $button.type = 'button';
    $button.classList.add('toc-nested-collapsible__toggle');
    $button.setAttribute('aria-expanded', 'false');
    $button.setAttribute('aria-controls', listId);

    $label.classList.add('toc-nested-collapsible__toggle-label');
    $label.textContent = 'Expand ' + $link.textContent;
    $icon.classList.add('toc-nested-collapsible__toggle-icon');
    $icon.setAttribute('aria-hidden', 'true');

    $button.appendChild($label);
    $button.appendChild($icon);

    $button.addEventListener('click', function (event) {
        event.preventDefault();
        this.toggleItem($item);
    }.bind(this));

    return $button;
};

OnboardingNavigation.prototype.findLink = function (path) {
    var $links = this.$module.querySelectorAll('a[href]');

    for (var i = 0; i < $links.length; i++) {
        if (this.getAbsolutePath($links[i]) === path) {
            return $links[i];
        }
    }
};

OnboardingNavigation.prototype.findDirectList = function ($item) {
    for (var i = 0; i < $item.children.length; i++) {
        if ($item.children[i].tagName.toLowerCase() === 'ul') {
            return $item.children[i];
        }
    }
};

OnboardingNavigation.prototype.getAbsolutePath = function ($link) {
    return new URL($link.getAttribute('href'), window.location.href).pathname;
};

OnboardingNavigation.prototype.openCurrentBranch = function () {
    var currentPath = window.location.pathname;
    var $items = this.$module.querySelectorAll('.toc-nested-collapsible');

    $items.forEach(function ($item) {
        var $links = $item.querySelectorAll('a[href]');
        var containsCurrentPage = Array.prototype.some.call($links, function ($link) {
            return this.getAbsolutePath($link) === currentPath;
        }, this);

        if (containsCurrentPage) {
            this.toggleItem($item, true);
        }
    }, this);
};

OnboardingNavigation.prototype.toggleItem = function ($item, setOpen) {
    var $link = $item.querySelector('a[href]');
    var $button = $item.querySelector('.toc-nested-collapsible__toggle');
    var $label = $item.querySelector('.toc-nested-collapsible__toggle-label');
    var isOpen = typeof setOpen === 'boolean' ? setOpen : !$item.classList.contains('is-open');

    $item.classList.toggle('is-open', isOpen);
    $button.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
    $label.textContent = (isOpen ? 'Collapse ' : 'Expand ') + $link.textContent;
};

new OnboardingNavigation(document.querySelector('#toc')).init();

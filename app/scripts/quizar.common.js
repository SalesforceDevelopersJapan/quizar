var EFFECT_TIME = 300;
function enableInput($input, b) {
	if (b) {
		$input.removeAttr("disabled");
	} else {
		$input.attr("disabled", "disabled");
	}
}
function normalizeMultiline(str) {
	return str.split("\n").filter(function(v) { return v.length > 0}).join("\n");
}
function copyIdToName($el) {
	$el.each(function() {
		var $input = $(this),
				id = $input.attr("id");
		if (id) {
			$input.attr("name", id);
		}
	});
	return $el;
}
function clearHash(hash) {
	for (var name in hash) {
		delete hash[name];
	}
}
function optionControl($ctrl, $panel) {
	if (!$panel) {
		$panel = $ctrl.find(".option-panel");
		$ctrl = $ctrl.find(".option-ctrl");
	}
	$ctrl.click(function() {
		var $i = $ctrl.find("i");
		if ($i.hasClass("fa-caret-down")) {
			$i.removeClass("fa-caret-down").addClass("fa-caret-up");
			$ctrl.addClass("active");
		} else {
			$i.removeClass("fa-caret-up").addClass("fa-caret-down");
			$ctrl.removeClass("active");
		}
		$panel.slideToggle();
	})
}
function backButtonControl($el) {
	var $pagingBar = $el.find(".paging-bar");
	if ($pagingBar.length) {
		var $div = $pagingBar.parent(),
			$button = $pagingBar.find("button.back-btn");
		if ($button.length) {
			$div.swipe({
				"swipeRight": function(e) {
					$button.click();
					e.stopImmediatePropagation();
				},
				"tap": function (event, target) {
					if (SUPPORTS_TOUCH) {
						$(target).click();
					}
				}
			})
		}
	}
}
function roundTime(t) {
	return Math.round(t / 10) / 100;
}
function slideIn($el, direction) {
	$el.show("slide", {"direction" : direction}, EFFECT_TIME);
}

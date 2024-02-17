#!/usr/bin/env node

document.addEventListener("DOMContentLoaded", function () {
	const themeSwitch = document.getElementById("theme-switch");
	const prefersDarkScheme = window.matchMedia("(prefers-color-scheme: dark)");

	if (localStorage.getItem("theme")) {
		// Préférence enregistrée
		document.body.classList.toggle(
			"dark-mode",
			localStorage.getItem("theme") === "dark"
		);
	} else if (prefersDarkScheme.matches) {
		// Préférence système
		document.body.classList.add("dark-mode");
	}

	themeSwitch.checked = document.body.classList.contains("dark-mode");
themeSwitch.addEventListener("change", function () {
		document.body.classList.toggle("dark-mode");
		localStorage.setItem(
			"theme",
			document.body.classList.contains("dark-mode") ? "dark" : "light"
		);
	});
});

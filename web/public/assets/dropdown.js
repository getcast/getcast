toggles = document.getElementsByClassName("toggle-dropdown")
length = toggles.length
for (var i = 0; i < length; i++) {
	target = document.getElementById(toggles[i].dataset.target)
	toggles[i].addEventListener("click",
		function (event) {
			target.classList.toggle("show")
		}
	)
}
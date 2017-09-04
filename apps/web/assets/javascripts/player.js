// Based on the code : https://github.com/alexanderkatz/HTML5-Audio
document.addEventListener("DOMContentLoaded", function(event) {

var podcast = document.getElementById('podcast'); // id for podcast episode
var duration; //Duration in seconds
var totalDuration; // duraiton in string version
var playButton = document.getElementById('playButton'); //Play/pause button
var marker = document.getElementById('marker'); // Marker on timeline
var timeline = document.getElementById('timeline'); // timeline
var timestamp = document.getElementById('timestamp') //time stamp (Duration )
// timeline width adjusted for marker
var timelineWidth = timeline.offsetWidth - marker.offsetWidth;

// play button event listenter
playButton.addEventListener("click", play);

// timeupdate event listener
podcast.addEventListener("timeupdate", timeUpdate, false);

// makes timeline clickable
timeline.addEventListener("click", function(event) {
    movemarker(event);
    podcast.currentTime = duration * clickPercent(event);
}, false);

// returns click as decimal (.77) of the total timelineWidth
function clickPercent(event) {
    return (event.clientX - getPosition(timeline)) / timelineWidth;

}

// makes marker draggable
marker.addEventListener('mousedown', mouseDown, false);
window.addEventListener('mouseup', mouseUp, false);

// Boolean value so that audio position is updated only when the marker is released
var onmarker = false;

// mouseDown EventListener
function mouseDown() {
    onmarker = true;
    window.addEventListener('mousemove', movemarker, true);
    podcast.removeEventListener('timeupdate', timeUpdate, false);
}

// mouseUp EventListener
// getting input from all mouse clicks
function mouseUp(event) {
    if (onmarker == true) {
        movemarker(event);
        window.removeEventListener('mousemove', movemarker, true);
        // change current time
        podcast.currentTime = duration * clickPercent(event);
        podcast.addEventListener('timeupdate', timeUpdate, false);
    }
    onmarker = false;
}
// mousemove EventListener
// Moves marker as user drags
function movemarker(event) {
    var newMargLeft = event.clientX - getPosition(timeline);

    if (newMargLeft >= 0 && newMargLeft <= timelineWidth) {
        marker.style.marginLeft = newMargLeft + "px";
    }
    if (newMargLeft < 0) {
        marker.style.marginLeft = "0px";
    }
    if (newMargLeft > timelineWidth) {
        marker.style.marginLeft = timelineWidth + "px";
    }
}

// timeUpdate
// Synchronizes marker position with current point in audio
function timeUpdate() {
    var playPercent = timelineWidth * (podcast.currentTime / duration);
    marker.style.marginLeft = playPercent + "px";
    if (podcast.currentTime == duration) {
        playButton.className = "";
        playButton.className = "play";
    }
    timestamp.innerHTML = Math.floor(Math.floor(podcast.currentTime/ 60)/60) + ":" + Math.floor(podcast.currentTime/ 60) % 60 + ":" + Math.ceil(podcast.currentTime) % 60 + "/" + totalDuration;
}

//Play and Pause
function play() {
    // start podcast
    if (podcast.paused) {
        podcast.play();
        // remove play, add pause
        playButton.className = "";
        playButton.className = "pause";
    } else { // pause podcast
        podcast.pause();
        // remove pause, add play
        playButton.className = "";
        playButton.className = "play";
    }
}

// Gets audio file duration
podcast.addEventListener("canplaythrough", function() {
    duration = podcast.duration;
    totalDuration = Math.floor(Math.floor(duration/ 60)/60) + ":" + Math.floor(duration/ 60) % 60 + ":" + Math.ceil(duration) % 60;
    timestamp.innerHTML = Math.floor(Math.floor(podcast.currentTime/ 60)/60) + ":" + Math.floor(podcast.currentTime/ 60) % 60 + ":" + Math.ceil(podcast.currentTime) % 60 + "/" + totalDuration;
}, false);


function getPosition(el) {
    return el.getBoundingClientRect().left;
}

});
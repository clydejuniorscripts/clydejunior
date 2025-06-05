let processingTimerInterval;

function startTimer(duration, action) {
    let timer = duration / 1000;
    const display = document.getElementById('processing-timer-display');
    const timerDiv = document.getElementById('processing-timer');
    timerDiv.classList.remove('hidden');

    processingTimerInterval = setInterval(() => {
        let minutes = Math.floor(timer / 60);
        let seconds = timer % 60;

        display.textContent = `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;

        if (--timer < 0) {
            clearInterval(processingTimerInterval);
            timerDiv.classList.add('hidden');
        }
    }, 1000);
}

function stopTimer() {
    clearInterval(processingTimerInterval);
    document.getElementById('processing-timer').classList.add('hidden');
}

window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.action === 'startProcessing') {
        startTimer(data.duration, data.action);
    } else if (data.action === 'stopProcessing') {
        stopTimer();
    }
});

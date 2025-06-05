let cookingTimerInterval;

function startTimer(duration, action) {
    let timer = duration / 1000;
    const display = document.getElementById('cooking-timer-display');
    const timerDiv = document.getElementById('cooking-timer');
    timerDiv.classList.remove('hidden');

    cookingTimerInterval = setInterval(() => {
        let minutes = Math.floor(timer / 60);
        let seconds = timer % 60;

        display.textContent = `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;

        if (--timer < 0) {
            clearInterval(cookingTimerInterval);
            timerDiv.classList.add('hidden');
        }
    }, 1000);
}

function stopTimer() {
    clearInterval(cookingTimerInterval);
    document.getElementById('cooking-timer').classList.add('hidden');
}

window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.action === 'startCooking') {
        startTimer(data.duration, data.action);
    } else if (data.action === 'stopCooking') {
        stopTimer();
    }
});

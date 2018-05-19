var app = document.getElementById('mention');

var typewriter = new Typewriter(app, {
    loop: true
});

typewriter.typeString('겪고 있는 문제가 있나요?\n')
    .pauseFor(1000)
    .typeString('투정으로 끝나지 않게, 해결책이 될 법안을 찾아줄게요.')
    .pauseFor(2500)
    .start();

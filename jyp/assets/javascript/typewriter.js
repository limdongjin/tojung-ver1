var app = document.getElementById('mention');

var typewriter = new Typewriter(app, {
    loop: true
});

typewriter.typeString('겪고 있는 문제가 있나요?\n')
    .pauseFor(1000)
    .typeString('지금 바로 말해주세요. 당신의 투정.')
    .pauseFor(2500)
    .start();

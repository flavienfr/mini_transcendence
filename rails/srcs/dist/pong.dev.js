"use strict";

//select the canvas
var canvas = document.getElementById("pong");
var context = canvas.getContext("2d");
canvas.addEventListener("mousemove", movePaddle); // part 1 functions draw
// draw score

function drawScore(x, y, score, color) {
  context.fillStyle = color;
  context.font = "35px fantasy"; // pas responsive

  context.fillText(score, x, y);
} // draw rect


function drawRect(x, y, w, h, color) {
  context.fillStyle = color;
  context.fillRect(x, y, w, h);
} // draw ball


function drawBall(x, y, r, color) {
  context.fillStyle = color;
  context.beginPath();
  context.arc(x, y, r, 0, Math.PI * 2, false);
  context.closePath();
  context.fill();
} //part 2 users padlle
//User1


var user1 = {
  x: 0,
  y: canvas.height / 2 - 100 / 2,
  // le 100 / 2 pas responsive
  width: 10,
  // pas responsive
  height: 100,
  // pas responsive
  color: "WHITE",
  score: 0
}; //User2

var user2 = {
  x: canvas.width - 10,
  // pas responsive il s'agit de largeur (10px)
  y: canvas.height / 2 - 100 / 2,
  // le 100 / 2 pas responsive correspond au paddle
  width: 10,
  // pas responsive
  height: 100,
  // pas responsive
  color: "WHITE",
  score: 0
}; // Part 3 the ball

var ball = {
  x: canvas.width / 2,
  y: canvas.height / 2,
  // for be at the center
  radius: 10,
  // pas responsive
  speed: 5,
  // a voir si pas assez rapide ou trop
  velocityX: 5,
  velocityY: 5,
  color: "RED"
}; //part render function

var net = {
  x: canvas.width / 2 - 1,
  y: 0,
  width: 2,
  height: 10,
  color: "WHITE"
};

function drawNet() {
  for (var i = 0; i <= canvas.height; i += 20) {
    // pas responsive
    drawRect(net.x, net.y + i, net.width, net.height, net.color);
  }
}

function render() {
  // const part
  drawRect(0, 0, canvas.width, canvas.height, "BLACK"); // the game place

  drawNet();
  drawScore(canvas.width / 4, canvas.height / 5, user1.score, "WHITE");
  drawScore(3 * canvas.width / 4, canvas.height / 5, user2.score, "WHITE"); // move part

  drawRect(user1.x, user1.y, user1.width, user1.height, user1.color);
  drawRect(user2.x, user2.y, user2.width, user2.height, user2.color);
  drawBall(ball.x, ball.y, ball.radius, ball.color);
}

function collision(ba, paddle) // paddle of the player
{
  ba.top = ba.y - ba.radius; // this is for know the limite of each point of the ball

  ba.bottom = ba.y + ba.radius;
  ba.left = ba.x - ba.radius;
  ba.right = ba.x + ba.radius;
  paddle.top = paddle.y; // this is for know the limit of each point of the paddle

  paddle.bottom = paddle.height + paddle.y;
  paddle.left = paddle.x;
  paddle.right = paddle.x + paddle.width; // if are true there is collision else if one is false no collision

  return ba.right > paddle.left && ba.bottom > paddle.top && ba.left < paddle.right && ba.top < paddle.bottom;
}

function restartBall() {
  ball.x = canvas.width / 2, ball.y = canvas.height / 2, // for be at the center
  ball.radius = 10, // pas responsive
  ball.speed = 5, // a voir si pas assez rapide ou trop
  ball.velocityX = 5, ball.velocityY = 5, ball.color = "RED";
}

function update() // remake of cub3d for userdeplacement but her is the ball
{
  ball.x += ball.velocityX;
  ball.y += ball.velocityY;

  if (ball.y + ball.radius > canvas.height || ball.y - ball.radius < 0) {
    ball.velocityY = -ball.velocityY;
  }

  var player = ball.x < canvas.width / 2 ? user1 : user2; // determine if the ball is on the right or the left for know what colision place should be watch

  if (collision(ball, player) == true) {
    var col = ball.y - (player.y + player.height / 2); // set the colision point

    col = col / (player.height / 2); // normalize the colision point 

    var angleRad = col * Math.PI / 4; // determine the angle

    var direction = ball.x < canvas.width / 2 ? 1 : -1; // set if the ball should go to the right or left

    ball.velocityX = direction * ball.speed * Math.cos(angleRad); // calcyte the x deplacement + speed

    ball.velocityY = direction * ball.speed * Math.sin(angleRad); // calculate the y deplacement + speed

    ball.speed += 0.2; // icrease the speed at each contact with the paddle
  }

  if (ball.x - ball.radius < 0) {
    user2.score++;
    restartBall();
  }

  if (ball.x + ball.radius > canvas.width) {
    user1.score++;
    restartBall();
  }
}

function movePaddle(evt) {
  user1.y = evt.clientY - canvas.getBoundingClientRect().top - user1.height / 2;
  user2.y = evt.clientY - canvas.getBoundingClientRect().top - user2.height / 2; // pour tester a brancher avec backbone et actioncable
}

function playing() {
  update();
  render();
}

setInterval(playing, 1000 / 50); // permet d'avoir 50 image par seconde ce qui est suffisant pour etre fluide et pas surcharger le server
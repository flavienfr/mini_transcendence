//select the canvas and event of mouse
const canvas = document.getElementById("pong");
const context = canvas.getContext("2d");
canvas.addEventListener("mousemove", movePaddle);

// part 1 functions draw
// draw score
function drawScore(x, y,score ,color){
    context.fillStyle = color;
    context.font = "35px fantasy"; // pas responsive
    context.fillText(score, x, y);
}

//draw the line at the middle
function drawMidleLine(){
    for(let i =  0; i <= canvas.height; i += 20){  // pas responsive
        drawRect(line.x, line.y + i, line.width, line.height, line.color);
    }
}


// draw rect
function drawRect(x,y,w,h,color){
    context.fillStyle = color;
    context.fillRect(x,y,w,h);
}

// draw ball
function drawBall(x,y,r,color){
    context.fillStyle = color;
    context.beginPath();
    context.arc(x,y,r,0, Math.PI*2, false);
    context.closePath();
    context.fill();

}

//part 2 users padlle
//User1
const user1 = { 
    //position
    x : 0, 
    y : canvas.height/2 - 100 / 2, // le 100 / 2 pas responsive
    //form 
    width : 10, // pas responsive
    height : 100, // pas responsive
    color : "WHITE",
    score : 0
}
//User2
const user2 = {
    //position
    x : canvas.width - 10, // pas responsive il s'agit de largeur (10px)
    y : canvas.height/2 - 100 / 2, // le 100 / 2 pas responsive correspond au paddle
    //form
    width : 10, // pas responsive
    height : 100, // pas responsive
    color : "WHITE",
    score : 0
}

// Part 3 the ball
const ball =  {
    //position
    x : canvas.width/2,
    y : canvas.height/2, // for be at the center
    //form
    radius : 10, // pas responsive
    speed : 5, // a voir si pas assez rapide ou trop
    velocityX : 5,
    velocityY : 5,
    color : "RED" 
}


//part 4 render 

const line = {
    //pos
    x : canvas.width / 2 - 1, 
    y : 0,
    //form
    width : 2, 
    height : 10,
    color : "WHITE"
}

function render(){ // the order is important
// const part
drawRect(0,0, canvas.width, canvas.height,"BLACK"); // the game place
drawMidleLine();
drawScore(canvas.width/4, canvas.height/5, user1.score, "WHITE");
drawScore(3 * canvas.width/4, canvas.height/5, user2.score, "WHITE");
// move part
drawRect(user1.x, user1.y, user1.width, user1.height, user1.color);
drawRect(user2.x, user2.y, user2.width, user2.height, user2.color);
drawBall(ball.x, ball.y, ball.radius, ball.color);


}

// part 5 collision and rules
//collision
function get_collision(ba, paddle) // paddle of the player
{
    ba.top = ba.y - ba.radius; // this is for know the limite of each point of the ball
    ba.bottom = ba.y + ba.radius;
    ba.left = ba.x - ba.radius;
    ba.right = ba.x + ba.radius;

    paddle.top = paddle.y; // this is for know the limit of each point of the paddle
    paddle.bottom = paddle.height + paddle.y;
    paddle.left = paddle.x;
    paddle.right = paddle.x + paddle.width;
    
    // if are true there is get_collision else if one is false no get_collision
    return ba.right > paddle.left && ba.bottom > paddle.top && ba.left < paddle.right && ba.top < paddle.bottom;
}

//restart when it's finished
// penser a faire une fonction qui demander d'entrer pour demander si les joueurs sont pret et ensuite launch the game

function restartBall()
{
    ball.x = canvas.width/2,
    ball.y =  canvas.height/2, // for be at the center
    ball.radius =  10, // pas responsive
    ball.speed = 5, // check if it's to or less speed
    ball.velocityX = 5,
    ball.velocityY = 5,
    ball.color = "RED" 
}


function isFinish()
{
    if (ball.x - ball.radius < 0) // if the ball is to the left
    {
        user2.score++;
        restartBall();
    }
    if (ball.x + ball.radius > canvas.width) // if the ball is to the right
    {    user1.score++;
        restartBall();
    }
}

function sync() // remake of cub3d for userdeplacement but her is the ball
{
    ball.x += ball.velocityX;
    ball.y += ball.velocityY;

    if (ball.y + ball.radius > canvas.height || ball.y - ball.radius < 0){
        ball.velocityY =  -ball.velocityY;  
    }
    
    let player = (ball.x < canvas.width/2) ? user1 : user2; // determine if the ball is on the right or the left

    if (get_collision(ball, player) == true)
    {
        let col = ball.y - (player.y + player.height/2); // set the colision point
        col = col/(player.height/2); // normalize the colision point 
        
        let angleRad = col * Math.PI/4; // determine the angle to return 

        let direction = (ball.x < canvas.width/2) ? 1 : -1; // set if the ball should go to the right or left
        ball.velocityX =direction * ball.speed * Math.cos(angleRad); // calculate the x deplacement + speed
        ball.velocityY = direction * ball.speed * Math.sin(angleRad); // calculate the y deplacement + speed

        ball.speed += 0.2; // icrease the speed at each contact with the paddle
    }
    isFinish();
}

function movePaddle(event){ // function to permite to change the direction of the users paddle with the mouse
    user1.y = event.clientY - canvas.getBoundingClientRect().top - user1.height/2;
    user2.y = event.clientY - canvas.getBoundingClientRect().top - user2.height/2; // pour tester a brancher avec backbone et actioncable     
}

function playing()
{
    sync();
    render();
}

setInterval(playing, 1000/50); // permet d'avoir 50 image par seconde ce qui est suffisant pour etre fluide et pas surcharger le server
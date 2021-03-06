var cocos = require('cocos2d');
var geom = require('geometry');
var util = require('util');

var Ball = cocos.nodes.Node.extend({
    velocity: null,
    collisionNodes: null,
    init: function() {
        Ball.superclass.init.call(this);
        var sprite = cocos.nodes.Sprite.create({
            file: '/resources/sprites.png',
            rect: new geom.Rect(64, 0, 16, 16)
        });
         
        sprite.set('anchorPoint', new geom.Point(0, 0));
        this.addChild({child: sprite});
        this.set('contentSize', sprite.get('contentSize'));
        
        this.set('velocity', new geom.Point(60, 120));
        this.scheduleUpdate();
    },
    update: function(dt) {
        var pos = util.copy(this.get('position')),
            vel = util.copy(this.get('velocity'));
        pos.x += dt * vel.x;
        pos.y += dt * vel.y;
        this.set('position', pos);
        this.testBatCollision();
        this.testEdgeCollision();
        this.testCollisionNodes();
    },
    testCollisionNodes: function() {
        var bricks = this.get('parent').get('bricks');
        for (var i = 0; i < bricks.length; i++)
        {
            var brick = bricks[i];
            if (brick)
            {
                var brickBox = brick.get('boundingBox');
                var ballBox = this.get('boundingBox');
                if (geom.rectOverlapsRect(brickBox, ballBox)) {
                    var intersection = geom.rectIntersection(brickBox, ballBox);
                    if (intersection.origin.x != NaN) {
                        var vel = util.copy(this.get('velocity'));
                        if (intersection.size.width > intersection.size.height) {
                            vel.y *= -1;
                        }
                        else {
                            vel.x *= -1;
                        }
                        this.set('velocity', vel);
                        brick.ballCollision();
                    }
                }
            }
        }

    },
    testEdgeCollision: function() {
        var vel = util.copy(this.get('velocity')),
            ballBox = this.get('boundingBox'),
            // Get size of canvas
            winSize = cocos.Director.get('sharedDirector').get('winSize');
        
        // Moving left and hit left edge
        if (vel.x < 0 && geom.rectGetMinX(ballBox) < 0) {
            // Flip X velocity
            vel.x *= -1;
        } 
        // Moving right and hit right edge
        if (vel.x > 0 && geom.rectGetMaxX(ballBox) > winSize.width) {
            // Flip X velocity
            vel.x *= -1;
        }
        // Moving up and hit top edge
        if (vel.y < 0 && geom.rectGetMinY(ballBox) < 0) {
            // Flip Y velocity
            vel.y *= -1;
        }
        this.set('velocity', vel);
    },
    testBatCollision: function() {
        var vel = util.copy(this.get('velocity')),
            ballBox = this.get('boundingBox'),
     
            // The parent of the ball is the Breakout Layer, which has a 'bat'
            // property pointing to the player's bat.
            batBox = this.get('parent').get('bat').get('boundingBox');
     
        // If moving down then check for collision with the bat
        if (vel.y > 0) {
            if (geom.rectOverlapsRect(ballBox, batBox)) {
                // Flip Y velocity
                vel.y *= -1;
                var horizontalAcceleration = ((ballBox.origin.x + (ballBox.size.width / 2)) - (batBox.origin.x + batBox.size.width / 2)) * 5;
                vel.x += horizontalAcceleration;
                //console.log(horizontalAcceleration);
            }
        }
     
        // Update position and velocity on the ball
        this.set('velocity', vel);
    }
});

exports.Ball = Ball;
// Import the cocos2d module
var cocos = require('cocos2d'),
// Import the geometry module
    geo = require('geometry');
    
// Personal files
//   Import my Bat module
var Bat = require('Bat').Bat,
//  Import my Ball module
    Ball = require('Ball').Ball,
    Brick = require('Brick').Brick;


// Create a new layer
var Navigation = cocos.nodes.Layer.extend({
    bat: null,
    ball: null,
    brick: null,
    init: function() {
        // You must always call the super class version of init
        Navigation.superclass.init.call(this);

        // Get size of canvas
        var s = cocos.Director.get('sharedDirector').get('winSize');
        // Create label
        // var label = cocos.nodes.Label.create({string: 'Navigation', fontName: 'Arial', fontSize: 76});
        // Add label to layer
        // this.addChild({child: label, z:1});
        // Position the label in the centre of the view
        // label.set('position', geo.ccp(s.width / 2, s.height / 2));
        
        // Add the bat: 
        var bat = Bat.create();
        bat.set('position', new geo.Point(160, 280));
        this.set('bat', bat);
        
        // Add the ball
        var ball = Ball.create();
        ball.set('position', new geo.Point(160, 250));
        this.set('ball', ball);

        // Add Bricks
        var bricks = [];
        for (var i = 0; i < 3; i++)
        {
            var brick = Brick.create();
            brick.set('position', new geo.Point((i + 1) * 64, 100));
            bricks.push(brick);
            this.addChild({child: brick});
        }
        this.set('bricks', bricks);

        this.addChild({child:bat});
        this.addChild({child: ball});
        this.set('isMouseEnabled', true);
    },
    mouseMoved: function(evt) {
        var bat = this.get('bat');
        var batPos = bat.get('position');
        batPos.x = evt.locationInCanvas.x;
        bat.set('position', batPos);
    }
});

exports.main = function() {
    // Initialise application

    // Get director
    var director = cocos.Director.get('sharedDirector');

    // Attach director to our <div> element
    director.attachInView(document.getElementById('navigation_app'));

    // Create a scene
    var scene = cocos.nodes.Scene.create();

    // Add our layer to the scene
    scene.addChild({child: Navigation.create()});

    // Run the scene
    director.runWithScene(scene);
};

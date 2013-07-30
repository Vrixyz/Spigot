var cocos = require('cocos2d');
var geom = require('geometry');

var Brick = cocos.nodes.Node.extend({
    init: function() {
        Brick.superclass.init.call(this);
        var sprite = cocos.nodes.Sprite.create({
            file: '/resources/sprites.png',
            rect: new geom.Rect(0, 32, 32, 16)
        });
        sprite.set('anchorPoint', new geom.Point(0, 0));
        this.addChild({child: sprite});
        this.set('contentSize', sprite.get('contentSize'));
    },
    ballCollision: function() {
        var bricks = this.get('parent').get('bricks');
        bricks[bricks.indexOf(this)] = null;
        
        this.get('parent').detatchChild({child: this, cleanup: true});
        delete this;

    }
});

exports.Brick = Brick;
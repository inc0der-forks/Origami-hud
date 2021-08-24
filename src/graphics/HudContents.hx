package graphics;

import pm.system.Statistic;
import pm.manager.Plugins;
import pm.graphic.Base;
import pm.graphic.Text;
import pm.core.Game;
import pm.core.Player;

using extensions.Player;

class HudContents extends Base {
  var actorText: Text;
  var game: Game;
  var gauge: Gauge;
  var hpStat: Statistic;
  var leader: Player;

  public function new() {
    super();
    hpStat = Plugins.getParameter('OrigamiHUD', 'Health Stat');
    leader = Game.current.teamHeroes[0];
    actorText = new Text(leader.name, {
      fontSize: 20
    });

    gauge = {
      value: getActorHp(leader),
      max: getActorHp(leader, true),
      color: '#f75456',
      text: 'Health'
    };

  }

  public function getActorHp(actor: Player, ?isMax: Bool = false) {
    if (isMax) {
      return Reflect.getProperty(actor, hpStat.getMaxAbbreviation());
    }
    return Reflect.getProperty(actor, hpStat.abbreviation);
  }
  
  public override function update() {
    gauge.updateValue(getActorHp(leader));
  }

  public override function draw(x: Float, y: Float, w: Float, h: Float, ?positionResize: Bool): Void {
    actorText.draw(x, y);
    gauge.draw(x, y + 20, w, 20);
    trace(x, y, w, h);
  }
}

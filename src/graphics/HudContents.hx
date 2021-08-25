package graphics;

import pm.system.Statistic;
import pm.manager.Plugins;
import pm.graphic.Base;
import pm.graphic.Text;
import pm.core.Game;
import pm.core.Player;
import pm.core.Enums.Align;

class HudContents extends Base {
  var actorNameText: Text;
  var actorLevelText: Text;
  var game: Game;
  var healthGauge: Gauge;
  var expGauge: Gauge;
  var hpStat: Statistic;
  var expStat: Statistic;
  var leader: Player;

  public function new() {
    super();
    hpStat = Plugins.getParameter('OrigamiHUD', 'Health Stat');
    expStat = Plugins.getParameter('OrigamiHUD', 'Experience Stat');
    leader = Game.current.teamHeroes[0];
    actorNameText = new Text(leader.name, {
      fontSize: 20
    });

    actorLevelText = new Text('Level ${leader.getCurrentLevel()}', {
      fontSize: 20,
      align: Align.Right
    });

    healthGauge = {
      value: getActorStatValue(leader, hpStat),
      max: getActorStatValue(leader, hpStat, true),
      color: '#f75456',
      text: hpStat.name()
    };

    expGauge = {
      value: getActorStatValue(leader, expStat),
      max: getActorStatValue(leader, expStat, true),
      color: '#1262b7',
      text: expStat.name()
    };

  }

  public function getActorStatValue(actor: Player, stat: Statistic,  ?isMax: Bool = false) {
    if (isMax) {
      return Reflect.getProperty(actor, stat.getMaxAbbreviation());
    }
    return Reflect.getProperty(actor, stat.abbreviation);
  }
  
  public override function update() {
    var hp = getActorStatValue(leader, hpStat);
    var mhp = getActorStatValue(leader, hpStat, true);
    var exp = getActorStatValue(leader, expStat);
    var maxExp = getActorStatValue(leader, expStat, true);

    healthGauge.updateValue(hp, mhp, true);
    expGauge.updateValue(exp, maxExp);
  }

  public override function draw(x: Float, y: Float, w: Float, h: Float, ?positionResize: Bool): Void {
    actorNameText.draw(x, y);
    actorLevelText.draw(x, y, w);
    healthGauge.draw(x, y + 20, w, 20);
    expGauge.draw(x, y + 45, w, 15);
  }
}

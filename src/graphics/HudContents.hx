package graphics;

import pm.system.Statistic;
import pm.manager.Plugins;
import pm.graphic.Base;
import pm.graphic.Text;
import pm.core.Game;
import pm.core.Player;
import pm.core.Enums.Align;

typedef GaugeOptions = {
  fontSize: Int,
  stat: Statistic
}

class HudContents extends Base {
  var actorNameText: Text;
  var actorLevelText: Text;
  var game: Game;
  var healthGauge: Gauge;
  var expGauge: Gauge;
  var hpGaugeOptions: GaugeOptions;
  var expGaugeOptions: GaugeOptions;
  var leader: Player;

  public function new() {
    super();
    hpGaugeOptions = Plugins.getParameter('OrigamiHUD', 'HP Gauge');
    expGaugeOptions = Plugins.getParameter('OrigamiHUD', 'Exp Gauge');

    trace(hpGaugeOptions);
    leader = Game.current.teamHeroes[0];
    actorNameText = new Text(leader.name, {
      fontSize: 20
    });

    actorLevelText = new Text('Level ${leader.getCurrentLevel()}', {
      fontSize: 20,
      align: Align.Right
    });

    healthGauge = {
      value: getActorStatValue(leader, hpGaugeOptions.stat),
      max: getActorStatValue(leader, hpGaugeOptions.stat, true),
      color: '#f75456',
      text: hpGaugeOptions.stat.name()
    };

    expGauge = {
      value: getActorStatValue(leader, expGaugeOptions.stat),
      max: getActorStatValue(leader, expGaugeOptions.stat, true),
      color: '#1262b7',
      text: expGaugeOptions.stat.name()
    };

  }

  public function getActorStatValue(actor: Player, stat: Statistic,  ?isMax: Bool = false) {
    if (isMax) {
      return Reflect.getProperty(actor, stat.getMaxAbbreviation());
    }
    return Reflect.getProperty(actor, stat.abbreviation);
  }
  
  public override function update() {
    var hp = getActorStatValue(leader, hpGaugeOptions.stat);
    var mhp = getActorStatValue(leader, hpGaugeOptions.stat, true);
    var exp = getActorStatValue(leader, expGaugeOptions.stat);
    var maxExp = getActorStatValue(leader, expGaugeOptions.stat, true);

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

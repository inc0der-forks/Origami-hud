package scenes;

import pm.manager.Plugins;
import pm.scene.Map_;
import pm.core.WindowBox;
import graphics.HudContents;

class Map {
  static var window: WindowBox;
  static var contents: HudContents;

  public static function createHudWindow() {
    var width = 200;
    var height = 100;
    contents = new HudContents();
    window = new WindowBox(5, 5, width, height, {
      content: contents,
      padding: WindowBox.MEDIUM_PADDING_BOX
    });
  }

  public static function setup() {
    Plugins.inject(Map_, 'load', (self: Map_) -> {
      createHudWindow();
    });

    Plugins.inject(Map_, 'update', (self: Map_) -> {
      window.update();
    });

    Plugins.inject(Map_, 'drawHUD', () -> {
      window.draw();
    });
  }
}

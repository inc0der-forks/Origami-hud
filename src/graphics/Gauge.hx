package graphics;

import pm.core.Enums.AlignVertical;
import pm.core.Enums.Align;
import pm.core.Bitmap;
import pm.common.Platform;
import pm.graphic.Text;
import pm.common.ScreenResolution;

@:build(macros.BuildMacros.structInitDefaults())
@:structInit
class Gauge extends Bitmap {
  private var nameText: Text;
  private var valuesText: Text;
  private var rate: Float;
  @required
  var value: Float;
  var max: Float;
  var text: String;
  var strokeWidth: Float;
  var strokeColor: String;
  var backColor: String;
  var color: String;
  var fontSize: Float;

  private static function defaultValue(value: Any, defaultValue: Any) {
    return value == null ? defaultValue : value;
  }

  public function new() {
    super();
    this.value = value;
    this.text = text;
    this.max = defaultValue(max, value);
    this.color = defaultValue(color, '#f75456');
    this.strokeWidth = defaultValue(strokeWidth, 1);
    this.strokeColor = defaultValue(strokeColor, '#1c2226');
    this.color = defaultValue(color, '#f75456');
    this.backColor = defaultValue(backColor, '#010411');
    this.fontSize = defaultValue(fontSize, 16);
    this.rate = value / max;

    if (this.text != null) {
      nameText = new Text(text, {
        fontSize: this.fontSize,
        align: Align.Left,
        verticalAlign: AlignVertical.Center
      });
    }

    valuesText = new Text('${value} / ${max}', {
      fontSize: this.fontSize,
      align: Align.Right,
      verticalAlign: AlignVertical.Center
    });
  }

  public function updateValue(value: Float) {
    if (this.value != value) {
      this.value = value;
      valuesText.setText('${value} / ${max}');
      rate = value / max;
    }
  }

  public function update() {}

  public function draw(x: Float, y: Float, w: Float, h: Float) {
    var x2 = ScreenResolution.getScreenX(x);
    var y2 = ScreenResolution.getScreenY(y);
    var w2 = ScreenResolution.getScreenX(w);
    var h2 = ScreenResolution.getScreenY(h);
    Platform.ctx.save();
    Platform.ctx.beginPath();
    Platform.ctx.fillStyle = backColor;
    Platform.ctx.fillRect(x2, y2, w2, h2);
    Platform.ctx.fillStyle = color;
    Platform.ctx.fillRect(x2, y2, w2 * rate, h2);
    Platform.ctx.lineWidth = strokeWidth;
    Platform.ctx.strokeStyle = strokeColor;
    Platform.ctx.strokeRect(x2, y2, w2, h2);
    Platform.ctx.restore();
    if (nameText != null) {
      nameText.draw(x, y, w, h);
    }
    if (valuesText != null) {
      valuesText.draw(x, y, w, h);
    }
  }
}

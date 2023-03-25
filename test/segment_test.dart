import 'package:test/test.dart';
import 'package:my_app/segments.dart';

void main() {
  test('Debe crearse un Segmento', () {
    final segment = Segment('Parque', 'Inicio', 'Fin');

    expect(segment.name, 'Parque');
    expect(segment.inicio, 'Inicio');
    expect(segment.fin, 'Fin');
  });
}

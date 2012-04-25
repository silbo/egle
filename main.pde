// ATMEL ATTINY85
//
//                  +-\/-+
// Ain0 (D 5) PB5  1|    |8  Vcc
// Ain3 (D 3) PB3  2|    |7  PB2 (D 2)  Ain1
// Ain2 (D 4) PB4  3|    |6  PB1 (D 1) pwm1
//            GND  4|    |5  PB0 (D 0) pwm0
//                  +----+

int8_t red[3] = { LOW, HIGH, HIGH };
int8_t green[3] = { HIGH, LOW, HIGH };
int8_t blue[3] = { HIGH, HIGH, LOW };
int8_t purple[3] = { LOW, HIGH, LOW };
int8_t black[3] = { HIGH, HIGH, HIGH };
int8_t white[3] = { LOW, LOW, LOW };

int setColor( int8_t color[3], int millis )
{
	digitalWrite( 0, color[0] );
	digitalWrite( 1, color[1] );
	digitalWrite( 2, color[2] );
	if ( millis > 0 ) delay( millis );
	return 0;
}

void setup()
{
	pinMode( 0, OUTPUT );
	pinMode( 1, OUTPUT );
	pinMode( 2, OUTPUT );
	pinMode( 4, INPUT );

	setColor( red, 1000 );
	setColor( green, 1000 );
	setColor( blue, 1000 );
	setColor( purple, 1000 );
	setColor( black, 1000 );
	digitalWrite( 4, LOW );
}

int value;
void loop()
{
	if ( digitalRead( 4 ) ) {
		value = analogRead( 3 );
		if ( 400 < value && value < 600 ) setColor( red, 0 );//33k,46k
		else if ( 600 < value && value < 800 ) setColor( green, 0 );//10k
		else if ( 800 < value && value < 1000 ) setColor( blue, 0 );//3k,3.8k,2k
		else setColor( white, 0 );
	} else {
		setColor( black, 0 );
	}
}

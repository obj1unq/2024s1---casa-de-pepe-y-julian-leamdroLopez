object casaDePepeYJulian {

	var property porcentajeViveres = 50
	var montoReparaciones = 0
	var property cuenta = cuentaCorriente

	method hayViveres() {
		return porcentajeViveres > 40
	}

	method hayReparaciones() {
		return montoReparaciones > 0
	}

	method sumarReparaciones(monto) {
		montoReparaciones += monto
	}

	method hayOrden() {
		return self.hayViveres() and not self.hayReparaciones()
	}

	method gastar(cantidad) {
		cuenta.extraer(cantidad)
	}

}

object cuentaCorriente {

	var property saldo = 0

	method depositar(cantidad) {
		saldo += cantidad
	}

	method extraer(cantidad) {
		saldo -= cantidad
	}

}

object cuentaGastos {

	var property saldo = 0
	var property costoOperacion = 0

	method depositar(cantidad) {
		saldo += cantidad - self.costoOperacion()
	}

	method extraer(cantidad) {
		saldo -= cantidad
	}

}

object cuentaCombinada {

	var property cuentaPrimaria = cuentaGastos
	var property cuentaSecundaria = cuentaCorriente

	method saldo() {
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	}

	method depositar(cantidad) {
		cuentaPrimaria.depositar(cantidad)
	}

	method extraer(cantidad) {
		if (cuentaPrimaria.saldo() >= cantidad) {
			cuentaPrimaria.extraer(cantidad)
		} else {
			cuentaSecundaria.extraer(cantidad)
		}
	}

}


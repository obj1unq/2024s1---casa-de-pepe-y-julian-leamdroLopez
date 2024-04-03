object casaDePepeYJulian {

	var property porcentajeViveres = 50
	var property montoReparaciones = 0
	var property cuenta = cuentaCorriente
	var property estrategiaAhorro = minimo

	method hayViveres() {
		return porcentajeViveres > 40
	}

	method hayReparaciones() {
		return montoReparaciones > 0
	}

	method romperAlgo(valor) {
		montoReparaciones += valor
	}

	method hayOrden() {
		return self.hayViveres() and not self.hayReparaciones()
	}

	method gastar(cantidad) {
		cuenta.extraer(cantidad)
	}

	method comprarViveres(porcentaje) {
		porcentajeViveres += porcentaje
	}

	method hacerReparaciones() {
		self.montoReparaciones(0)
	}

	method hacerReparacionesSiSobra() {
		if (cuenta.saldo() > montoReparaciones + 1000) {
			self.hacerReparaciones()
		}
	}

	method hacerMantenimiento() {
		estrategiaAhorro.hacerMantenimientoA(self)
	}

}

object minimo {

	var property calidad = 0

	method porcentajePara(casa) {
		return if (not casa.hayViveres()) {
			40 - casa.porcentajeViveres()
		} else 0
	}

	method hacerMantenimientoA(casa) {
		casa.gastar(self.porcentajePara(casa) * calidad)
		casa.comprarViveres(self.porcentajePara(casa))
	}

}

object full {

	const property calidad = 5

	method porcentajePara(casa) {
		return if (casa.hayOrden()) {
			100 - casa.porcentajeViveres()
		} else 40
	}

	method hacerMantenimientoA(casa) {
		casa.gastar(self.porcentajePara(casa) * calidad)
		casa.comprarViveres(self.porcentajePara(casa))
		casa.hacerReparacionesSiSobra()
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


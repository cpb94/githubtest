$PBExportHeader$w_liquidacion_comisiones.srw
forward
global type w_liquidacion_comisiones from w_int_con_empresa
end type
type pb_1 from upb_salir within w_liquidacion_comisiones
end type
type cb_continuar from commandbutton within w_liquidacion_comisiones
end type
type st_4 from statictext within w_liquidacion_comisiones
end type
type tipo from statictext within w_liquidacion_comisiones
end type
type em_fapunte from u_em_campo within w_liquidacion_comisiones
end type
type st_1 from statictext within w_liquidacion_comisiones
end type
type cb_1 from commandbutton within w_liquidacion_comisiones
end type
type st_2 from statictext within w_liquidacion_comisiones
end type
type gb_3 from groupbox within w_liquidacion_comisiones
end type
type gb_2 from groupbox within w_liquidacion_comisiones
end type
type pb_imprimir from upb_imprimir within w_liquidacion_comisiones
end type
type pb_imprimir_factura from upb_imprimir within w_liquidacion_comisiones
end type
type st_5 from statictext within w_liquidacion_comisiones
end type
type st_3 from statictext within w_liquidacion_comisiones
end type
type dw_factura from datawindow within w_liquidacion_comisiones
end type
type uo_ejercicio from u_ejercicio within w_liquidacion_comisiones
end type
type em_anyo from editmask within w_liquidacion_comisiones
end type
type em_documento from u_em_campo within w_liquidacion_comisiones
end type
type st_6 from statictext within w_liquidacion_comisiones
end type
type st_7 from statictext within w_liquidacion_comisiones
end type
type st_8 from statictext within w_liquidacion_comisiones
end type
type em_ffact_desde from u_em_campo within w_liquidacion_comisiones
end type
type em_ffact_hasta from u_em_campo within w_liquidacion_comisiones
end type
type uo_agente from u_em_campo_2 within w_liquidacion_comisiones
end type
type tab_1 from tab within w_liquidacion_comisiones
end type
type pendientes from userobject within tab_1
end type
type dw_pendientes from u_datawindow within pendientes
end type
type pendientes from userobject within tab_1
dw_pendientes dw_pendientes
end type
type asignadas from userobject within tab_1
end type
type dw_asignadas from datawindow within asignadas
end type
type asignadas from userobject within tab_1
dw_asignadas dw_asignadas
end type
type tab_1 from tab within w_liquidacion_comisiones
pendientes pendientes
asignadas asignadas
end type
type gb_1 from groupbox within w_liquidacion_comisiones
end type
type cbx_cabecera from checkbox within w_liquidacion_comisiones
end type
end forward

global type w_liquidacion_comisiones from w_int_con_empresa
integer width = 3625
integer height = 1992
pb_1 pb_1
cb_continuar cb_continuar
st_4 st_4
tipo tipo
em_fapunte em_fapunte
st_1 st_1
cb_1 cb_1
st_2 st_2
gb_3 gb_3
gb_2 gb_2
pb_imprimir pb_imprimir
pb_imprimir_factura pb_imprimir_factura
st_5 st_5
st_3 st_3
dw_factura dw_factura
uo_ejercicio uo_ejercicio
em_anyo em_anyo
em_documento em_documento
st_6 st_6
st_7 st_7
st_8 st_8
em_ffact_desde em_ffact_desde
em_ffact_hasta em_ffact_hasta
uo_agente uo_agente
tab_1 tab_1
gb_1 gb_1
cbx_cabecera cbx_cabecera
end type
global w_liquidacion_comisiones w_liquidacion_comisiones

type variables
string detalle="S",con="1",todo = "S"
datastore lineas_detalle
boolean marcadas = false
end variables

forward prototypes
public function boolean f_apuntes_contables ()
public subroutine f_generar_documento_liquidacion ()
public function boolean f_anyade_linea_doc_liquidacion (integer arg_anyo_doc, integer arg_doc, integer arg_anyo_fra, long arg_fra, integer arg_linea, decimal arg_importe_liquidado)
public function boolean f_borra_linea_doc_liquidacion (integer arg_anyo_doc, integer arg_doc, integer arg_anyo_fra, long arg_fra, integer arg_linea, decimal arg_importe_liquidado)
public function decimal f_pdte_cobro_fra (integer arg_anyo, long arg_fra)
end prototypes

public function boolean f_apuntes_contables ();str_contaapun conta
String  ante
Integer v_bien,r,r1
Dec     acumulado = 0,acu2 = 0

IF tipo_vista<> "Nacional"  Then Return true

r1     = tab_1.pendientes.dw_pendientes.RowCount()
v_bien = 0
acu2   = 0
conta.empresa   = codigo_empresa
conta.fapunte   = DateTime(Date(em_fapunte.text))
conta.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
conta.origen    = "5"
conta.mes       = Month(date(conta.fapunte))
conta.asiento   = f_ultimo_asiento(conta.ejercicio,conta.empresa,conta.mes,conta.origen)
conta.concepto  = "8"
conta.apunte    = 0
ante= ""

For r = 1 To r1
    IF tab_1.pendientes.dw_pendientes.object.marca[r] = "S" Then
			acumulado  = acumulado + tab_1.pendientes.dw_pendientes.object.importeliquidarpts[r]
			iF (Trim(ante)<> "" and ante <> tab_1.pendientes.dw_pendientes.object.agente[r]) Then
					IF acu2<>0 then
							conta.apunte  = conta.apunte + 1
							IF Not f_insert_contaapun(conta) Then 	
									v_bien = 1
									f_mensaje("Error","AL GRABAR ASIENTO")
							END IF
					End if
					acu2 = 0
			END IF
			acu2              = acu2 + tab_1.pendientes.dw_pendientes.object.importeliquidarpts[r]
			conta.ampliacion  = f_nombre_mes(conta.mes)+ "  " +f_nombre_venagentes(conta.empresa,tab_1.pendientes.dw_pendientes.object.agente[r])
			conta.divisas     = acu2
			conta.debe        = acu2
			conta.haber       = 0
			conta.deducible   = "N"
			conta.actualizado = "N"
			conta.listado     = "N"
			SetNull(conta.registro)
			SetNUll(conta.tipoter) 
			SetNUll(conta.clipro)
			SetNull(conta.conciliado)
			SetNUll(conta.nif)
			SetNull(conta.punteado)
			SetNull(conta.fvalor)
			SetNull(conta.docpunteo)
			SetNull(conta.coste)
			SetNull(conta.fregistro)
			conta.moneda      = tab_1.pendientes.dw_pendientes.object.moneda[r]
			conta.cambio      = 1
			conta.documento   = ""
			conta.factura     = ""
			SetNUll(conta.ffactura)  
			conta.imponible   = 0
			SetNull(conta.tipoiva)
			SetNUll(conta.iva)
			conta.cuenta      = f_cuenta_venagentes(codigo_empresa,tab_1.pendientes.dw_pendientes.object.agente[r])
			ante = tab_1.pendientes.dw_pendientes.object.agente[r]
   END IF
	f_mensaje_proceso("Procesando Apuntes.......",r,r1)
Next
conta.apunte  = conta.apunte + 1
if acu2<>0 then
		IF Not f_insert_contaapun(conta) Then 	
				v_bien = 1
				f_mensaje("Error","AL GRABAR ASIENTO")
		END IF
End if

conta.apunte     = conta.apunte + 1
conta.debe       = 0
conta.haber      = acumulado
conta.divisas    = acumulado
conta.ampliacion = f_nombre_mes(conta.mes)
conta.cuenta     = "41200999"
IF Not f_insert_contaapun(conta) Then 	
	v_bien = 1
	f_mensaje("Error","AL GRABAR ASIENTO")
END IF

if v_bien = 1 Then
	Return False
Else
	Return True
End If



end function

public subroutine f_generar_documento_liquidacion ();string   mascara_moneda_empresa
Integer  indice,total,liquidacion,lineas_marcadas = 0
Dec      impliqui,impliquipts,v_anyo,v_factura,v_linea,anyo_liquidacion
datetime fecha_liquidacion
decimal  v_comision_liquidada
boolean  bien = true

str_car_doc_liq_comisiones car_doc_liq_comisiones

mascara_moneda_empresa = f_mascara_moneda(f_moneda_empresa(codigo_empresa))

total = tab_1.asignadas.dw_asignadas.RowCount()

fecha_liquidacion = datetime(date(em_fapunte.text))
anyo_liquidacion  = year(date(fecha_liquidacion))
 
// Último nº de liquidación
select max(doc_liquidacion) 
into   :liquidacion
from   car_doc_liq_comisiones
where	 empresa = :codigo_empresa
and	 anyo    = :anyo_liquidacion;
		
if isnull(liquidacion) then liquidacion = 0

liquidacion = liquidacion + 1

car_doc_liq_comisiones.empresa         = codigo_empresa
car_doc_liq_comisiones.anyo            = anyo_liquidacion
car_doc_liq_comisiones.doc_liquidacion = liquidacion
car_doc_liq_comisiones.agente          = uo_agente.em_codigo.text
car_doc_liq_comisiones.fliquidacion    = fecha_liquidacion
car_doc_liq_comisiones.importe_liquidado     = 0
car_doc_liq_comisiones.importe_gastos_fletes = 0
car_doc_liq_comisiones.importe_iva           = 0
car_doc_liq_comisiones.importe_irpf          = 0

select irpf,
		 tipo_iva
into   :car_doc_liq_comisiones.irpf,
		 :car_doc_liq_comisiones.tipo_iva
from   venagentes
where  empresa = :car_doc_liq_comisiones.empresa
and    agente  = :car_doc_liq_comisiones.agente;

if sqlca.sqlcode <> 0 then bien = false

if isnull(car_doc_liq_comisiones.irpf) then car_doc_liq_comisiones.irpf = 0
if isnull(car_doc_liq_comisiones.tipo_iva) then car_doc_liq_comisiones.tipo_iva = ""

car_doc_liq_comisiones.iva = f_iva_contaiva(car_doc_liq_comisiones.anyo,codigo_empresa,car_doc_liq_comisiones.tipo_iva)
car_doc_liq_comisiones.fecha_inicio_facturas = datetime(date(em_ffact_desde.text))
car_doc_liq_comisiones.fecha_fin_facturas    = datetime(date(em_ffact_hasta.text))
car_doc_liq_comisiones.usuario               = nombre_usuario
car_doc_liq_comisiones.fecha_creacion_documento    = datetime(today(),now())
car_doc_liq_comisiones.usuario_ultima_modificacion = nombre_usuario
car_doc_liq_comisiones.fecha_ultima_modificacion   = car_doc_liq_comisiones.fecha_creacion_documento

for indice = 1 to total
	if tab_1.asignadas.dw_asignadas.object.marca[indice] = "S" Then
		lineas_marcadas ++
		
		v_anyo               = tab_1.asignadas.dw_asignadas.object.anyo[indice]
		v_factura            = tab_1.asignadas.dw_asignadas.object.factura[indice]
		v_linea              = tab_1.asignadas.dw_asignadas.object.linea[indice]
		v_comision_liquidada = tab_1.asignadas.dw_asignadas.object.comision_liquidada[indice]
		
		car_doc_liq_comisiones.importe_liquidado = car_doc_liq_comisiones.importe_liquidado + v_comision_liquidada
		
		update carcomisiones 
		set    liquidado = "S"  ,
				 importeliquidadopts            = :v_comision_liquidada,
				 carcomisiones.fliquidacion     = :fecha_liquidacion,
				 carcomisiones.doc_liquidacion  = :liquidacion,
				 carcomisiones.anyo_liquidacion = :anyo_liquidacion
		where  carcomisiones.empresa = :codigo_empresa
		and    carcomisiones.anyo    = :v_anyo 
		and    carcomisiones.factura = :v_factura 
		and    carcomisiones.linea   = :v_linea;
		
		if SQLCA.SQLCODE <> 0 then bien = false
	
	end if
	
	f_mensaje_proceso("Cancelando recibos.......",indice,total)
   
Next
// No hacemos apuntes contables
//IF Not f_apuntes_contables() Then vbien = 1

if lineas_marcadas > 0 then
	if car_doc_liq_comisiones.iva <> 0 then
		car_doc_liq_comisiones.importe_iva = (car_doc_liq_comisiones.importe_liquidado * car_doc_liq_comisiones.iva) / 100
	else
		car_doc_liq_comisiones.importe_iva = 0
	end if
	
	if car_doc_liq_comisiones.irpf <> 0 then
		car_doc_liq_comisiones.importe_irpf = (car_doc_liq_comisiones.importe_liquidado * car_doc_liq_comisiones.irpf) / 100
	else
		car_doc_liq_comisiones.importe_irpf = 0
	end if	
	
	car_doc_liq_comisiones.importe_iva = dec(string(car_doc_liq_comisiones.importe_iva,mascara_moneda_empresa))
	car_doc_liq_comisiones.importe_irpf = dec(string(car_doc_liq_comisiones.importe_irpf,mascara_moneda_empresa))


	insert into car_doc_liq_comisiones
		(car_doc_liq_comisiones.empresa,
		 car_doc_liq_comisiones.anyo,
		 car_doc_liq_comisiones.doc_liquidacion,
		 car_doc_liq_comisiones.agente,
		 car_doc_liq_comisiones.fliquidacion,
		 car_doc_liq_comisiones.importe_liquidado,
		 car_doc_liq_comisiones.importe_gastos_fletes,
		 car_doc_liq_comisiones.importe_iva,
		 car_doc_liq_comisiones.importe_irpf,
		 car_doc_liq_comisiones.tipo_iva,
		 car_doc_liq_comisiones.iva,
		 car_doc_liq_comisiones.irpf,
		 car_doc_liq_comisiones.fecha_inicio_facturas,
		 car_doc_liq_comisiones.fecha_fin_facturas,
		 car_doc_liq_comisiones.usuario,
		 car_doc_liq_comisiones.fecha_creacion_documento,
		 car_doc_liq_comisiones.usuario_ultima_modificacion,
		 car_doc_liq_comisiones.fecha_ultima_modificacion)
	values
		(:car_doc_liq_comisiones.empresa,
		 :car_doc_liq_comisiones.anyo,
		 :car_doc_liq_comisiones.doc_liquidacion,
		 :car_doc_liq_comisiones.agente,
		 :car_doc_liq_comisiones.fliquidacion,
		 :car_doc_liq_comisiones.importe_liquidado,
		 :car_doc_liq_comisiones.importe_gastos_fletes,
		 :car_doc_liq_comisiones.importe_iva,
		 :car_doc_liq_comisiones.importe_irpf,
		 :car_doc_liq_comisiones.tipo_iva,
		 :car_doc_liq_comisiones.iva,
		 :car_doc_liq_comisiones.irpf,
		 :car_doc_liq_comisiones.fecha_inicio_facturas,
		 :car_doc_liq_comisiones.fecha_fin_facturas,
		 :car_doc_liq_comisiones.usuario,
		 :car_doc_liq_comisiones.fecha_creacion_documento,
		 :car_doc_liq_comisiones.usuario_ultima_modificacion,
		 :car_doc_liq_comisiones.fecha_ultima_modificacion);
		 
	if sqlca.sqlcode <> 0 then
		bien = false
	end if
else
	bien = false
end if

IF bien Then
	COMMIT;
	em_anyo.text      = string(anyo_liquidacion,"###0")
	em_documento.text = string(liquidacion)	
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso","La Operacion no se contabiliza")
END IF
end subroutine

public function boolean f_anyade_linea_doc_liquidacion (integer arg_anyo_doc, integer arg_doc, integer arg_anyo_fra, long arg_fra, integer arg_linea, decimal arg_importe_liquidado);string   mascara_moneda_empresa
boolean  bien = true

str_car_doc_liq_comisiones car_doc_liq_comisiones

mascara_moneda_empresa = f_mascara_moneda(f_moneda_empresa(codigo_empresa))

car_doc_liq_comisiones.empresa         = codigo_empresa
car_doc_liq_comisiones.anyo            = arg_anyo_doc
car_doc_liq_comisiones.doc_liquidacion = arg_doc
car_doc_liq_comisiones.usuario_ultima_modificacion = nombre_usuario
car_doc_liq_comisiones.fecha_ultima_modificacion   = datetime(today(),now())

select car_doc_liq_comisiones.importe_liquidado,
		 car_doc_liq_comisiones.importe_gastos_fletes,
		 car_doc_liq_comisiones.iva,
		 car_doc_liq_comisiones.irpf
into   :car_doc_liq_comisiones.importe_liquidado,
		 :car_doc_liq_comisiones.importe_gastos_fletes,
		 :car_doc_liq_comisiones.iva,
		 :car_doc_liq_comisiones.irpf
from   car_doc_liq_comisiones
where  car_doc_liq_comisiones.empresa         = :codigo_empresa
and    car_doc_liq_comisiones.anyo            = :arg_anyo_doc
and    car_doc_liq_comisiones.doc_liquidacion = :arg_doc;

if sqlca.sqlcode <> 0 then
	bien = false
end if

if isnull(car_doc_liq_comisiones.importe_liquidado) then car_doc_liq_comisiones.importe_liquidado = 0
if isnull(car_doc_liq_comisiones.importe_gastos_fletes) then car_doc_liq_comisiones.importe_gastos_fletes = 0
if isnull(car_doc_liq_comisiones.iva) then car_doc_liq_comisiones.iva = 0
if isnull(car_doc_liq_comisiones.irpf) then car_doc_liq_comisiones.irpf = 0

car_doc_liq_comisiones.importe_liquidado = car_doc_liq_comisiones.importe_liquidado + arg_importe_liquidado

if car_doc_liq_comisiones.iva <> 0 then
	car_doc_liq_comisiones.importe_iva = (car_doc_liq_comisiones.importe_liquidado * car_doc_liq_comisiones.iva) / 100
else
	car_doc_liq_comisiones.importe_iva = 0
end if

if car_doc_liq_comisiones.irpf <> 0 then
	car_doc_liq_comisiones.importe_irpf = (car_doc_liq_comisiones.importe_liquidado * car_doc_liq_comisiones.irpf) / 100
else
	car_doc_liq_comisiones.importe_irpf = 0
end if	

car_doc_liq_comisiones.importe_iva  = dec(string(car_doc_liq_comisiones.importe_iva,mascara_moneda_empresa))
car_doc_liq_comisiones.importe_irpf = dec(string(car_doc_liq_comisiones.importe_irpf,mascara_moneda_empresa))

update car_doc_liq_comisiones
set    car_doc_liq_comisiones.importe_liquidado           = :car_doc_liq_comisiones.importe_liquidado,
		 car_doc_liq_comisiones.importe_gastos_fletes       = :car_doc_liq_comisiones.importe_gastos_fletes,
		 car_doc_liq_comisiones.importe_iva                 = :car_doc_liq_comisiones.importe_iva,
		 car_doc_liq_comisiones.importe_irpf                = :car_doc_liq_comisiones.importe_irpf,
	 	 car_doc_liq_comisiones.usuario_ultima_modificacion = :car_doc_liq_comisiones.usuario_ultima_modificacion,
	 	 car_doc_liq_comisiones.fecha_ultima_modificacion   = :car_doc_liq_comisiones.fecha_ultima_modificacion
where  car_doc_liq_comisiones.empresa         = :codigo_empresa
and    car_doc_liq_comisiones.anyo            = :arg_anyo_doc
and    car_doc_liq_comisiones.doc_liquidacion = :arg_doc;		
	 
if sqlca.sqlcode <> 0 then
	bien = false
end if

return bien
end function

public function boolean f_borra_linea_doc_liquidacion (integer arg_anyo_doc, integer arg_doc, integer arg_anyo_fra, long arg_fra, integer arg_linea, decimal arg_importe_liquidado);string   mascara_moneda_empresa
boolean  bien = true

str_car_doc_liq_comisiones car_doc_liq_comisiones

mascara_moneda_empresa = f_mascara_moneda(f_moneda_empresa(codigo_empresa))

car_doc_liq_comisiones.empresa         = codigo_empresa
car_doc_liq_comisiones.anyo            = arg_anyo_doc
car_doc_liq_comisiones.doc_liquidacion = arg_doc
car_doc_liq_comisiones.usuario_ultima_modificacion = nombre_usuario
car_doc_liq_comisiones.fecha_ultima_modificacion   = datetime(today(),now())

select car_doc_liq_comisiones.importe_liquidado,
		 car_doc_liq_comisiones.importe_gastos_fletes,
		 car_doc_liq_comisiones.iva,
		 car_doc_liq_comisiones.irpf
into   :car_doc_liq_comisiones.importe_liquidado,
		 :car_doc_liq_comisiones.importe_gastos_fletes,
		 :car_doc_liq_comisiones.iva,
		 :car_doc_liq_comisiones.irpf
from   car_doc_liq_comisiones
where  car_doc_liq_comisiones.empresa         = :codigo_empresa
and    car_doc_liq_comisiones.anyo            = :arg_anyo_doc
and    car_doc_liq_comisiones.doc_liquidacion = :arg_doc;

if sqlca.sqlcode <> 0 then
	bien = false
end if

if isnull(car_doc_liq_comisiones.importe_liquidado) then car_doc_liq_comisiones.importe_liquidado = 0
if isnull(car_doc_liq_comisiones.importe_gastos_fletes) then car_doc_liq_comisiones.importe_gastos_fletes = 0
if isnull(car_doc_liq_comisiones.iva) then car_doc_liq_comisiones.iva = 0
if isnull(car_doc_liq_comisiones.irpf) then car_doc_liq_comisiones.irpf = 0

car_doc_liq_comisiones.importe_liquidado = car_doc_liq_comisiones.importe_liquidado - arg_importe_liquidado

if car_doc_liq_comisiones.iva <> 0 then
	car_doc_liq_comisiones.importe_iva = (car_doc_liq_comisiones.importe_liquidado * car_doc_liq_comisiones.iva) / 100
else
	car_doc_liq_comisiones.importe_iva = 0
end if

if car_doc_liq_comisiones.irpf <> 0 then
	car_doc_liq_comisiones.importe_irpf = (car_doc_liq_comisiones.importe_liquidado * car_doc_liq_comisiones.irpf) / 100
else
	car_doc_liq_comisiones.importe_irpf = 0
end if	

car_doc_liq_comisiones.importe_iva  = dec(string(car_doc_liq_comisiones.importe_iva,mascara_moneda_empresa))
car_doc_liq_comisiones.importe_irpf = dec(string(car_doc_liq_comisiones.importe_irpf,mascara_moneda_empresa))

update car_doc_liq_comisiones
set    car_doc_liq_comisiones.importe_liquidado           = :car_doc_liq_comisiones.importe_liquidado,
		 car_doc_liq_comisiones.importe_gastos_fletes       = :car_doc_liq_comisiones.importe_gastos_fletes,
		 car_doc_liq_comisiones.importe_iva                 = :car_doc_liq_comisiones.importe_iva,
		 car_doc_liq_comisiones.importe_irpf                = :car_doc_liq_comisiones.importe_irpf,
	 	 car_doc_liq_comisiones.usuario_ultima_modificacion = :car_doc_liq_comisiones.usuario_ultima_modificacion,
	 	 car_doc_liq_comisiones.fecha_ultima_modificacion   = :car_doc_liq_comisiones.fecha_ultima_modificacion
where  car_doc_liq_comisiones.empresa         = :codigo_empresa
and    car_doc_liq_comisiones.anyo            = :arg_anyo_doc
and    car_doc_liq_comisiones.doc_liquidacion = :arg_doc;		
	 
if sqlca.sqlcode <> 0 then
	bien = false
end if

return bien
end function

public function decimal f_pdte_cobro_fra (integer arg_anyo, long arg_fra);string v_factura_string,sel,v_situacion_efecto
dec    v_pendiente_cartera_his,v_total_pendiente_factura,v_pendiente_cartera,v_importe_efecto
long   indice2,total2,v_orden_efecto,v_anyo_efecto
datetime v_fcobro_efecto

datastore ds_efectos

v_factura_string = string(arg_fra,"#######0")

v_pendiente_cartera_his = 0
 
//		select sum(importe)
//		into   :v_pendiente_cartera_his
//		from   carhistorico
//		where  empresa   = :codigo_empresa
//		and    anyofra   = :v_anyo
//		and    factura   = :v_factura_string
//		and    fcobro    >= :v_fechavto
//		and    (agrupado <>'S' or agrupado is null);

if isnull(v_pendiente_cartera_his) then v_pendiente_cartera_his = 0

v_total_pendiente_factura = v_total_pendiente_factura + v_pendiente_cartera_his

v_pendiente_cartera = 0

//		select sum(importe)
//		into   :v_pendiente_cartera
//		from   carefectos
//		where  empresa   = :codigo_empresa
//		and    anyofra   = :v_anyo
//		and    factura   = :v_factura_string
//		and    ((fcobro    >= :v_fechavto and situacion = "9")
//		or     situacion <> '9')
//		and    (agrupado <>'S' or agrupado is null);

select sum(importe)
into   :v_pendiente_cartera
from   carefectos
where  empresa   = :codigo_empresa
and    anyofra   = :arg_anyo
and    factura   = :v_factura_string
and    situacion <> '9'
and    situacion <> '3'
and    (agrupado <>'S' or agrupado is null);


if isnull(v_pendiente_cartera) then v_pendiente_cartera = 0

v_total_pendiente_factura = v_total_pendiente_factura + v_pendiente_cartera

sel = " select importe,efectoagrupa,anyoagrupa "+&
		" from   carefectos "+&
		" where  empresa   = '"+codigo_empresa+"' "+&
		" and    anyofra   = " +string(arg_anyo,"###0") +&
		" and    factura   = '" +v_factura_string+ "' "+&
		" and    situacion = '3' "

f_cargar_cursor_transaccion(sqlca,ds_efectos,sel)

total2 = ds_efectos.rowcount()

for indice2 = 1 to total2
	v_orden_efecto   = ds_efectos.object.efectoagrupa[indice2]
	v_anyo_efecto    = ds_efectos.object.anyoagrupa[indice2]
	v_importe_efecto = ds_efectos.object.importe[indice2]
	
	if isnull(v_importe_efecto) then
		v_importe_efecto = 0
	end if
	
	v_situacion_efecto = ""
	setnull(v_fcobro_efecto)
	
	select situacion,            fcobro
	into   :v_situacion_efecto, :v_fcobro_efecto
	from   carefectos
	where  empresa   = :codigo_empresa
	and    orden     = :v_orden_efecto
	and    anyo      = :v_anyo_efecto;
	
//			if v_situacion_efecto <> "9" or (v_situacion_efecto = "9" and v_fcobro_efecto >= v_fechavto) then
//				v_total_pendiente_factura = v_total_pendiente_factura + v_importe_efecto
//			end if
	if v_situacion_efecto <> "9" then
		v_total_pendiente_factura = v_total_pendiente_factura + v_importe_efecto
	end if
next

destroy ds_efectos

return v_total_pendiente_factura
end function

on w_liquidacion_comisiones.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_continuar=create cb_continuar
this.st_4=create st_4
this.tipo=create tipo
this.em_fapunte=create em_fapunte
this.st_1=create st_1
this.cb_1=create cb_1
this.st_2=create st_2
this.gb_3=create gb_3
this.gb_2=create gb_2
this.pb_imprimir=create pb_imprimir
this.pb_imprimir_factura=create pb_imprimir_factura
this.st_5=create st_5
this.st_3=create st_3
this.dw_factura=create dw_factura
this.uo_ejercicio=create uo_ejercicio
this.em_anyo=create em_anyo
this.em_documento=create em_documento
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.em_ffact_desde=create em_ffact_desde
this.em_ffact_hasta=create em_ffact_hasta
this.uo_agente=create uo_agente
this.tab_1=create tab_1
this.gb_1=create gb_1
this.cbx_cabecera=create cbx_cabecera
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_continuar
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.tipo
this.Control[iCurrent+5]=this.em_fapunte
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.pb_imprimir
this.Control[iCurrent+12]=this.pb_imprimir_factura
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.dw_factura
this.Control[iCurrent+16]=this.uo_ejercicio
this.Control[iCurrent+17]=this.em_anyo
this.Control[iCurrent+18]=this.em_documento
this.Control[iCurrent+19]=this.st_6
this.Control[iCurrent+20]=this.st_7
this.Control[iCurrent+21]=this.st_8
this.Control[iCurrent+22]=this.em_ffact_desde
this.Control[iCurrent+23]=this.em_ffact_hasta
this.Control[iCurrent+24]=this.uo_agente
this.Control[iCurrent+25]=this.tab_1
this.Control[iCurrent+26]=this.gb_1
this.Control[iCurrent+27]=this.cbx_cabecera
end on

on w_liquidacion_comisiones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_continuar)
destroy(this.st_4)
destroy(this.tipo)
destroy(this.em_fapunte)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.pb_imprimir)
destroy(this.pb_imprimir_factura)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.dw_factura)
destroy(this.uo_ejercicio)
destroy(this.em_anyo)
destroy(this.em_documento)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.em_ffact_desde)
destroy(this.em_ffact_hasta)
destroy(this.uo_agente)
destroy(this.tab_1)
destroy(this.gb_1)
destroy(this.cbx_cabecera)
end on

event open;call super::open;
istr_parametros.s_titulo_ventana =   "Liquidacion Agentes"
istr_parametros.s_listado        =   "report_conpromalb2"
This.title                       =   istr_parametros.s_titulo_ventana

tab_1.pendientes.dw_pendientes.SetTransObject(SQLCA)
dw_factura.SetTransObject(SQLCA)

em_ffact_desde.text = string(today(),"dd-mm-yy")
em_ffact_hasta.text = string(today(),"dd-mm-yy")
em_fapunte.text     = string(today(),"dd-mm-yy")

em_anyo.text = string(Year(Today()),"###0")

f_mascara_columna(tab_1.pendientes.dw_pendientes,"importeliquidarpts",f_mascara_decimales(0))


end event

event ue_pagina_abajo;//f_pagina_abajo(tab_1.pendientes.dw_pendientes)
end event

event ue_pagina_arriba;//f_pagina_arriba(dw_1)
end event

event ue_cursor_abajo;//f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;//f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_liquidacion_comisiones
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_liquidacion_comisiones
integer width = 87
integer height = 92
end type

event sle_opcion_orden::getfocus;//f_activar_campo(em_fechahasta)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_liquidacion_comisiones
integer textsize = -12
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 128
end type

type pb_1 from upb_salir within w_liquidacion_comisiones
integer x = 3474
integer y = 4
integer width = 110
integer height = 104
integer taborder = 0
end type

type cb_continuar from commandbutton within w_liquidacion_comisiones
event clicked pbm_bnclicked
integer x = 1184
integer y = 212
integer width = 283
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;String   filtro,agente,v_factura_string,sel,v_situacion_efecto
long     indice,total,indice2,total2,v_anyo,v_factura,v_orden_efecto,v_anyo_efecto
decimal  v_pendiente_cartera,v_pendiente_cartera_his,v_total_pendiente_factura,v_importe_efecto
Datetime v_fechavto,v_fcobro_efecto

datastore ds_efectos

tab_1.pendientes.dw_pendientes.setredraw(false)
filtro = ""

//v_fechavto = datetime(date(em_fechavto.text))

IF tipo_vista = "Nacional"    Then 
	filtro     = "carcomisiones_nacional = 'S'"
ELSE
  	IF tipo_vista = "Extranjero" then 
		filtro     = "carcomisiones_nacional = 'N'"
	else
		filtro     = ""
	end if
END IF


IF todo <> "S" Then
	if filtro <> "" then 
	 	filtro     = filtro + " and cobrado = 'S' and carcomisiones_control_fletes = 'S'"
	else
		filtro     = filtro + "cobrado = 'S' and carcomisiones_control_fletes = 'S'"
	end if	
END IF

if tipo_vista = "" or isnull(tipo_vista) then
	tipo.text  = "Ambos"
	tipo_vista = "Ambos"
else
	tipo.text = tipo_vista
end if

if em_ffact_desde.text = "00-00-00" or em_ffact_hasta.text = "00-00-00" then
	messagebox("Atencion", "Falta introducir las fechas")
	return
end if

tab_1.pendientes.dw_pendientes.SetFilter(filtro)
tab_1.pendientes.dw_pendientes.Filter()

//agente =	"%"

IF uo_agente.em_codigo.text <> "" Then
	agente =	uo_agente.em_codigo.text		
	
	//total = dw_1.retrieve(codigo_empresa,datetime(date(em_fechahasta.text)),agente)
	total = tab_1.pendientes.dw_pendientes.retrieve(codigo_empresa,agente,datetime(date(em_ffact_desde.text)),datetime(date(em_ffact_hasta.text)))
	marcadas = false
	
	For indice = 1 To total
	
		v_total_pendiente_factura = 0
		
		//f_mensaje_proceso("",indice,total)
		
		v_anyo           = tab_1.pendientes.dw_pendientes.object.anyo[indice]
		v_factura        = tab_1.pendientes.dw_pendientes.object.factura[indice]
		v_factura_string = string(v_factura,"#######0")
	
		v_pendiente_cartera_his = 0
		 
//		select sum(importe)
//		into   :v_pendiente_cartera_his
//		from   carhistorico
//		where  empresa   = :codigo_empresa
//		and    anyofra   = :v_anyo
//		and    factura   = :v_factura_string
//		and    fcobro    >= :v_fechavto
//		and    (agrupado <>'S' or agrupado is null);
		
		if isnull(v_pendiente_cartera_his) then v_pendiente_cartera_his = 0
	
		v_total_pendiente_factura = v_total_pendiente_factura + v_pendiente_cartera_his
		
		v_pendiente_cartera = 0
		
//		select sum(importe)
//		into   :v_pendiente_cartera
//		from   carefectos
//		where  empresa   = :codigo_empresa
//		and    anyofra   = :v_anyo
//		and    factura   = :v_factura_string
//		and    ((fcobro    >= :v_fechavto and situacion = "9")
//		or     situacion <> '9')
//		and    (agrupado <>'S' or agrupado is null);

//		select sum(importe)
//		into   :v_pendiente_cartera
//		from   carefectos
//		where  empresa   = :codigo_empresa
//		and    anyofra   = :v_anyo
//		and    factura   = :v_factura_string
//		and    situacion <> '9'
//		and    situacion <> '3'
//		and    (agrupado <>'S' or agrupado is null);
		
		select sum(importe_pendiente)
		into   :v_pendiente_cartera
		from (select isnull(sum(carefectos.importe),0) as importe_pendiente
				from   carefectos
				where  carefectos.empresa   = :codigo_empresa
				and    carefectos.anyofra   = :v_anyo
				and    carefectos.factura   = :v_factura_string
				and    situacion <> '9'
				and    situacion <> '3'
				union all
				select isnull(sum(agrupado_detalle.importe),0) as importe_pendiente
				from   carefectos as agrupado_cabecera,
						 carefectos as agrupado_detalle
				where  agrupado_cabecera.empresa = agrupado_detalle.empresa
				and    agrupado_cabecera.anyo    = agrupado_detalle.anyoagrupa
				and    agrupado_cabecera.orden   = agrupado_detalle.efectoagrupa
				and    agrupado_detalle.empresa  = :codigo_empresa
				and    agrupado_detalle.anyofra  = :v_anyo
				and    agrupado_detalle.factura  = :v_factura_string
				and    agrupado_detalle.situacion = '3'
				and    agrupado_cabecera.situacion <> '9'
				and    agrupado_cabecera.importe > 0) as resultado;		
		
		
		if isnull(v_pendiente_cartera) then v_pendiente_cartera = 0
	
		v_total_pendiente_factura = v_total_pendiente_factura + v_pendiente_cartera
		
//		sel = " select importe,efectoagrupa,anyoagrupa "+&
//				" from   carefectos "+&
//				" where  empresa   = '"+codigo_empresa+"' "+&
//				" and    anyofra   = " +string(v_anyo,"###0") +&
//				" and    factura   = '" +v_factura_string+ "' "+&
//				" and    situacion = '3' "
//		
//		f_cargar_cursor_transaccion(sqlca,ds_efectos,sel)
//		
//		total2 = ds_efectos.rowcount()
//		
//		for indice2 = 1 to total2
//			v_orden_efecto   = ds_efectos.object.efectoagrupa[indice2]
//			v_anyo_efecto    = ds_efectos.object.anyoagrupa[indice2]
//			v_importe_efecto = ds_efectos.object.importe[indice2]
//			
//			if isnull(v_importe_efecto) then
//				v_importe_efecto = 0
//			end if
//			
//			v_situacion_efecto = ""
//			setnull(v_fcobro_efecto)
//			
//			select situacion,            fcobro
//			into   :v_situacion_efecto, :v_fcobro_efecto
//			from   carefectos
//			where  empresa   = :codigo_empresa
//			and    orden     = :v_orden_efecto
//			and    anyo      = :v_anyo_efecto;
//			
////			if v_situacion_efecto <> "9" or (v_situacion_efecto = "9" and v_fcobro_efecto >= v_fechavto) then
////				v_total_pendiente_factura = v_total_pendiente_factura + v_importe_efecto
////			end if
//			if v_situacion_efecto <> "9" then
//				v_total_pendiente_factura = v_total_pendiente_factura + v_importe_efecto
//			end if
//		next
//		destroy ds_efectos

		//if v_total_pendiente_factura > 0 then
			tab_1.pendientes.dw_pendientes.object.marca[indice] = "N"		
		//else
			//tab_1.pendientes.dw_pendientes.object.marca[indice] = "S"
			//tab_1.pendientes.dw_pendientes.event itemchanged(indice,tab_1.pendientes.dw_pendientes.object.marca,"S")
		//end if
	
		tab_1.pendientes.dw_pendientes.object.carcomisiones_pendiente_cobro_fra[indice] = v_total_pendiente_factura
	Next
	
	tab_1.pendientes.dw_pendientes.Visible = true
	tab_1.pendientes.dw_pendientes.setredraw(true)
	
	tab_1.asignadas.dw_asignadas.reset()

end if


end event

type st_4 from statictext within w_liquidacion_comisiones
integer x = 23
integer y = 136
integer width = 1161
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Agente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type tipo from statictext within w_liquidacion_comisiones
integer x = 1184
integer y = 136
integer width = 283
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fapunte from u_em_campo within w_liquidacion_comisiones
integer x = 2080
integer y = 208
integer width = 279
integer taborder = 40
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event modificado;call super::modificado;if isdate(this.text) then
	em_anyo.text = string(year(date(this.text)),"###0")
end if
end event

type st_1 from statictext within w_liquidacion_comisiones
integer x = 2080
integer y = 136
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F. Liquid."
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_liquidacion_comisiones
integer x = 2798
integer y = 128
integer width = 457
integer height = 180
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar Doc. Liq."
end type

event clicked;decimal cobrado
long    op,op2,reg,i
string  naci,marca
boolean sin_cobrar
string  agente

em_documento.text = ""
sin_cobrar = false

if uo_agente.em_codigo.text = "" then
	messagebox("Error en Introducción de datos","Debe introducir un AGENTE")
	return
else
	agente = uo_agente.em_codigo.text
end if

reg = tab_1.asignadas.dw_asignadas.rowcount()

if reg > 0 then
	op = messagebox(" Atención "," ¿ Desea liquidar las comisiones seleccionadas ?",question!,yesno!,2)
	if op = 2 then return

	f_generar_documento_liquidacion()
		
		
end if


end event

type st_2 from statictext within w_liquidacion_comisiones
integer x = 2542
integer y = 136
integer width = 233
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Docu."
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_liquidacion_comisiones
integer x = 1486
integer y = 100
integer width = 571
integer height = 208
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "F.Cobro"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_liquidacion_comisiones
integer x = 2062
integer y = 100
integer width = 736
integer height = 208
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type pb_imprimir from upb_imprimir within w_liquidacion_comisiones
integer x = 3310
integer y = 188
integer taborder = 90
end type

event clicked;//
//f_cargar(dw_listado)
//
//f_imprimir_datawindow(dw_listado)

//f_recalcula_docs_liquidacion()
end event

type pb_imprimir_factura from upb_imprimir within w_liquidacion_comisiones
integer x = 3465
integer y = 188
integer taborder = 100
end type

event clicked;long     i,fila, total
string   marca, naci, agente, cabecera
boolean  alguno
long     v_factura,v_anyo,v_linea,anyo_doc,documento
string   v_razon, v_codigo_moneda
datetime v_ffra,f_desde,f_hasta,fliquidacion,v_fcobro
decimal  v_base_comision,v_comision,v_comision_liquidada,v_base_comision_divisa,v_comision_liquidada_divisa,v_impfrapts
alguno = false


if tab_1.asignadas.dw_asignadas.rowcount() <= 0 then
	messagebox("Atención","No hay efectos o no se ha consultado")
	return
end if

if em_documento.text = "" then
	messagebox("Atención","No hay numero de documento asignado")
	return
end if

if cbx_cabecera.checked then
	cabecera = "S"
else
	cabecera = "N"	
end if

//Imprimimos sin cabecera
//cabecera = "N"

f_mascara_columna(dw_factura,"basepts",f_mascara_moneda(f_moneda_empresa(codigo_empresa)))
f_mascara_columna(dw_factura,"comision",f_mascara_decimales(2))
f_mascara_columna(dw_factura,"comisionpts",f_mascara_moneda(f_moneda_empresa(codigo_empresa)))
f_mascara_columna(dw_factura,"total",f_mascara_moneda(f_moneda_empresa(codigo_empresa)))
f_mascara_columna(dw_factura,"tot",f_mascara_moneda(f_moneda_empresa(codigo_empresa)))
f_mascara_columna(dw_factura,"iva",f_mascara_moneda(f_moneda_empresa(codigo_empresa)))
f_mascara_columna(dw_factura,"irpf",f_mascara_moneda(f_moneda_empresa(codigo_empresa)))
f_mascara_columna(dw_factura,"base_imponible",f_mascara_moneda(f_moneda_empresa(codigo_empresa)))

tab_1.asignadas.dw_asignadas.setfilter(" marca = 'S' ")
tab_1.asignadas.dw_asignadas.filter()

total = tab_1.asignadas.dw_asignadas.rowcount()

if total = 0 then
	messagebox("Atención","No hay efectos seleccionados")
else
	anyo_doc     = long(em_anyo.text)
	documento    = long(em_documento.text)

	agente       = uo_agente.em_codigo.text
	
	fliquidacion = datetime(date(em_fapunte.text))
	f_desde      = datetime(date(em_ffact_desde.text))
	f_hasta      = datetime(date(em_ffact_hasta.text))
	
	dw_factura.retrieve(codigo_empresa,anyo_doc,documento,agente,cabecera)
	dw_factura.setredraw(false)	
	for i = 1 to total
		v_anyo               = tab_1.asignadas.dw_asignadas.object.anyo[i]		
		v_factura            = tab_1.asignadas.dw_asignadas.object.factura[i]	
		v_linea              = tab_1.asignadas.dw_asignadas.object.linea[i]	
		v_ffra               = tab_1.asignadas.dw_asignadas.object.ffra[i]			
		v_razon              = tab_1.asignadas.dw_asignadas.object.razon[i]			
		v_base_comision      = tab_1.asignadas.dw_asignadas.object.base_comision[i]			
		v_comision           = tab_1.asignadas.dw_asignadas.object.comision[i]
		v_comision_liquidada = tab_1.asignadas.dw_asignadas.object.comision_liquidada[i]
		v_fcobro                   = tab_1.asignadas.dw_asignadas.object.fcobro[i]
		v_impfrapts             = tab_1.asignadas.dw_asignadas.object.impfrapts[i]
		
		Select baseliqui,                comisionliqui,               moneda              
		into   :v_base_comision_divisa, :v_comision_liquidada_divisa, :v_codigo_moneda
		from   carcomisiones
		where  empresa         = :codigo_empresa
		and    anyo            = :v_anyo
		and    factura         = :v_factura
		and    linea           = :v_linea;
			
		if dw_factura.rowcount() < i then	
			if dw_factura.rowcount() = 0 then
				dw_factura.insertrow(0)
			else
				dw_factura.RowsCopy (1,1,Primary!,dw_factura,i,Primary!)	
			end if			
		end if
		fila = dw_factura.rowcount() 
			
		dw_factura.object.factura[fila]         = string(v_factura,"#####0")
		dw_factura.object.var_agente[fila]      = agente
		dw_factura.object.empresa[fila]         = codigo_empresa
		dw_factura.object.ffactura[fila]        = v_ffra
		dw_factura.object.razon[fila]           = v_razon
		dw_factura.object.basepts[fila]         = v_base_comision
		dw_factura.object.basedivisas[fila]     = v_base_comision_divisa
		dw_factura.object.codigo_moneda[fila]   = v_codigo_moneda
		dw_factura.object.moneda[fila]          = f_nombre_moneda_abr(v_codigo_moneda)
		dw_factura.object.comision[fila]        = v_comision
		dw_factura.object.comisionpts[fila]     = v_comision_liquidada
		dw_factura.object.comisiondivisas[fila] = v_comision_liquidada_divisa
		dw_factura.object.fcobro[fila] = v_fcobro
		dw_factura.object.impfrapts[fila] = v_impfrapts
		
		f_mensaje_proceso("Generando Fra "+string(i)+"/"+string(total),i,total)
		
	next
	
	dw_factura.setredraw(true)
	f_imprimir_datawindow(dw_factura)
	
end if
end event

type st_5 from statictext within w_liquidacion_comisiones
integer x = 3442
integer y = 132
integer width = 151
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fact."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_liquidacion_comisiones
integer x = 3287
integer y = 132
integer width = 151
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pant."
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_factura from datawindow within w_liquidacion_comisiones
boolean visible = false
integer x = 2245
integer width = 498
integer height = 96
string dataobject = "report_factura_agente"
boolean livescroll = true
end type

type uo_ejercicio from u_ejercicio within w_liquidacion_comisiones
event destroy ( )
boolean visible = false
integer x = 2939
integer y = 128
integer height = 172
integer taborder = 110
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type em_anyo from editmask within w_liquidacion_comisiones
integer x = 2368
integer y = 208
integer width = 169
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
string displaydata = "x"
end type

type em_documento from u_em_campo within w_liquidacion_comisiones
integer x = 2546
integer y = 208
integer width = 233
integer taborder = 60
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##########"
string displaydata = "Ä"
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DOCUMENTOS LIQUIDACIÓN"
ue_datawindow = "dw_ayuda_doc_liquidacion"
ue_filtro     = ""
if dec(em_anyo.text) > 0 then
	ue_filtro = "year(date(fliquidacion)) = "+string(dec(em_anyo.text),"###0")		
end if

//if isdate(em_fapunte.text) then
//	if ue_filtro <> "" then
//		ue_filtro = ue_filtro + " and "
//	end if
//	
//	ue_filtro = ue_filtro + "fliquidacion = '"+em_fapunte.text+"'"
//end if

if uo_agente.em_codigo.text <> "" then
	if ue_filtro <> "" then
		ue_filtro = ue_filtro + " and "
	end if
		
	ue_filtro     = ue_filtro + "agente = '"+uo_agente.em_codigo.text+"' "
end if
//isle_campo    = this

end event

event modificado;call super::modificado;string   sel,v_agente,codigo_agente,v_cliente,v_nombre_cliente,agente_doc,v_factura_string,v_situacion_efecto
long     indice,total,v_anyo,v_factura,v_linea,donde,anyo_doc,doc_liquidacion,indice2,total2,v_orden_efecto,v_anyo_efecto
datetime v_ffra,fliquidacion_doc,fecha_inicio_facturas_doc,fecha_fin_facturas_doc,v_fcobro_efecto,v_fcobro
decimal  v_base_comision,v_comision_liquidada,v_comision_pendiente_cobro, v_comision,v_impfrapts
dec      v_pendiente_cartera_his,v_total_pendiente_factura,v_pendiente_cartera,v_importe_efecto

datastore ds_comisiones,ds_efectos

if this.text <> "" then
	tab_1.asignadas.dw_asignadas.reset()
	
	anyo_doc        = long(em_anyo.text)
	doc_liquidacion = long(this.text)
	
	select agente,
			 fliquidacion,
			 fecha_inicio_facturas,
			 fecha_fin_facturas
	into   :agente_doc,
			 :fliquidacion_doc,
			 :fecha_inicio_facturas_doc,
			 :fecha_fin_facturas_doc
	from   car_doc_liq_comisiones
	where  empresa         = :codigo_empresa
	and    anyo            = :anyo_doc
	and    doc_liquidacion = :doc_liquidacion;
	
//	uo_agente.em_campo.text  = f_nombre_agente_doc(codigo_empresa,long(em_anyo.text),long(em_documento.text))
//	uo_agente.em_codigo.text = f_agente_doc(codigo_empresa,long(em_anyo.text),long(em_documento.text))
//	em_fapunte.text          = string(date(f_fecha_doc(codigo_empresa,long(em_anyo.text),long(em_documento.text))))

	uo_agente.em_codigo.text = agente_doc
	uo_agente.em_campo.text  = f_nombre_agente(codigo_empresa,uo_agente.em_codigo.text)	
	
	em_fapunte.text          = string(fliquidacion_doc,"dd-mm-yy") //string(date(f_fecha_doc(codigo_empresa,long(em_anyo.text),long(em_documento.text))))
	
	em_ffact_desde.text      = string(fecha_inicio_facturas_doc,"dd-mm-yy")
	em_ffact_hasta.text      = string(fecha_fin_facturas_doc,"dd-mm-yy")
	
	if Trim(uo_agente.em_campo.text) = "" then 
		if Trim(uo_agente.em_campo.text) <> "" Then f_activar_campo(em_documento)
		em_documento.text        = ""
		em_fapunte.text          = ""
		uo_agente.em_codigo.text = ""
	end if
	
	if cb_continuar.triggerevent(clicked!) = 1 then	
		if dec(em_documento.text) > 0 then
			tab_1.pendientes.dw_pendientes.setredraw(false)
			tab_1.asignadas.dw_asignadas.setredraw(false)
			//cb_continuar.triggerevent(clicked!)		
			
			sel = " Select empresa,anyo,factura,linea,ffra,agente,baseliquipts,impfrapts,comisionliquipts,comision,cliente,fcobro "+&
					" from   carcomisiones "+&
					" where  empresa          = '" + codigo_empresa + "' "+&
					" and    doc_liquidacion  = " + string(doc_liquidacion,"#######0") + " "+&
					" and    anyo_liquidacion = " + string(anyo_doc,"###0") + " " +&
					" and    liquidado        = 'S' "+&
					" and    agente           = '" + uo_agente.em_codigo.text + "' "+&
					" order  by anyo,factura "
		//			" and    fliquidacion    = '"  + string(datetime(date(em_fapunte.text)),formato_fecha_cursores) +"'"
		
					
			f_cargar_cursor_transaccion(sqlca,ds_comisiones,sel)		
		
			total = ds_comisiones.rowcount()	
		
			for indice = 1 to total
				 v_anyo    = ds_comisiones.object.anyo[indice]
				 v_factura = ds_comisiones.object.factura[indice]
				 v_linea   = ds_comisiones.object.linea[indice]
				 v_ffra    = ds_comisiones.object.ffra[indice]
				 v_agente  = ds_comisiones.object.agente[indice]
				 v_base_comision            = ds_comisiones.object.baseliquipts[indice]
				 v_comision_pendiente_cobro = ds_comisiones.object.impfrapts[indice]
				 v_comision_liquidada       = ds_comisiones.object.comisionliquipts[indice]
				 v_comision                 = ds_comisiones.object.comision[indice]
				 v_cliente                  = ds_comisiones.object.cliente[indice]
				 v_nombre_cliente           = f_nombre_cliente(codigo_empresa,"C",v_cliente)
				 v_fcobro                        = ds_comisiones.object.fcobro[indice]
				 v_impfrapts                     = ds_comisiones.object.impfrapts[indice]
				v_factura_string = string(v_factura,"#######0")
			
//				v_pendiente_cartera_his = 0
//				 				
//				if isnull(v_pendiente_cartera_his) then v_pendiente_cartera_his = 0
//			
//				v_total_pendiente_factura = v_total_pendiente_factura + v_pendiente_cartera_his
				v_total_pendiente_factura = 0
				v_pendiente_cartera = 0
						
				select sum(importe_pendiente)
				into   :v_pendiente_cartera
				from (select isnull(sum(carefectos.importe),0) as importe_pendiente
						from   carefectos
						where  carefectos.empresa   = :codigo_empresa
						and    carefectos.anyofra   = :v_anyo
						and    carefectos.factura   = :v_factura_string
						and    situacion <> '9'
						and    situacion <> '3'
						union all
						select isnull(sum(agrupado_detalle.importe),0) as importe_pendiente
						from   carefectos as agrupado_cabecera,
								 carefectos as agrupado_detalle
						where  agrupado_cabecera.empresa = agrupado_detalle.empresa
						and    agrupado_cabecera.anyo    = agrupado_detalle.anyoagrupa
						and    agrupado_cabecera.orden   = agrupado_detalle.efectoagrupa
						and    agrupado_detalle.empresa  = :codigo_empresa
						and    agrupado_detalle.anyofra  = :v_anyo
						and    agrupado_detalle.factura  = :v_factura_string
						and    agrupado_detalle.situacion = '3'
						and    agrupado_cabecera.situacion <> '9'
						and    agrupado_cabecera.importe > 0) as resultado;		
				
				
				if isnull(v_pendiente_cartera) then v_pendiente_cartera = 0
			
				v_total_pendiente_factura = v_total_pendiente_factura + v_pendiente_cartera
		
		
				 donde = tab_1.asignadas.dw_asignadas.insertrow(0)		 
				 tab_1.asignadas.dw_asignadas.object.marca[donde]              = "S"
				 tab_1.asignadas.dw_asignadas.object.empresa[donde]            = codigo_empresa
				 tab_1.asignadas.dw_asignadas.object.anyo[donde]               = v_anyo		 
				 tab_1.asignadas.dw_asignadas.object.factura[donde]            = v_factura
				 tab_1.asignadas.dw_asignadas.object.linea[donde]              = v_linea
				 tab_1.asignadas.dw_asignadas.object.ffra[donde]               = v_ffra
				 tab_1.asignadas.dw_asignadas.object.agente[donde]             = v_agente
				 tab_1.asignadas.dw_asignadas.object.razon[donde]              = v_nombre_cliente
				 tab_1.asignadas.dw_asignadas.object.base_comision[donde]      = v_base_comision
				 tab_1.asignadas.dw_asignadas.object.comision_pendiente_cobro[donde] = v_comision_pendiente_cobro		 
				 tab_1.asignadas.dw_asignadas.object.comision_liquidada[donde] = v_comision_liquidada
				 tab_1.asignadas.dw_asignadas.object.comision[donde]           = v_comision
				 tab_1.asignadas.dw_asignadas.object.comision_pendiente_cobro[donde] = v_total_pendiente_factura
				 tab_1.asignadas.dw_asignadas.object.fcobro[donde] = v_fcobro
				 tab_1.asignadas.dw_asignadas.object.impfrapts[donde]	         = v_impfrapts
				 
				 donde = tab_1.pendientes.dw_pendientes.insertrow(0)
				 
				 tab_1.pendientes.dw_pendientes.object.marca[donde]                  = "S"		 
				 tab_1.pendientes.dw_pendientes.object.empresa[donde]	               = codigo_empresa
				 tab_1.pendientes.dw_pendientes.object.anyo[donde]         	         = v_anyo		
				 tab_1.pendientes.dw_pendientes.object.factura[donde]	               = v_factura
				 tab_1.pendientes.dw_pendientes.object.linea[donde]           	      = v_linea		
				 tab_1.pendientes.dw_pendientes.object.ffra[donde]	                  = v_ffra
				 tab_1.pendientes.dw_pendientes.object.agente[donde]                 = v_agente
				 tab_1.pendientes.dw_pendientes.object.genter_razon[donde]           = v_nombre_cliente
				 tab_1.pendientes.dw_pendientes.object.carcomisiones_baseliquipts[donde] = v_base_comision
				 tab_1.pendientes.dw_pendientes.object.comision[donde]	            = v_comision
				 tab_1.pendientes.dw_pendientes.object.carcomisiones_pendiente_cobro_fra[donde] = v_comision_pendiente_cobro
				 tab_1.pendientes.dw_pendientes.object.carcomisiones_comisionliquipts[donde]	  = v_comision_liquidada
				tab_1.pendientes.dw_pendientes.object.carcomisiones_pendiente_cobro_fra[donde] = v_total_pendiente_factura				
				tab_1.pendientes.dw_pendientes.object.carcomisiones_fcobro[donde] = v_fcobro
				tab_1.pendientes.dw_pendientes.object.impfrapts[donde] = v_impfrapts				
				
//				sel = " select importe,efectoagrupa,anyoagrupa "+&
//						" from   carefectos "+&
//						" where  empresa   = '"+codigo_empresa+"' "+&
//						" and    anyofra   = " +string(v_anyo,"###0") +&
//						" and    factura   = '" +v_factura_string+ "' "+&
//						" and    situacion = '3' "
//				
//				f_cargar_cursor_transaccion(sqlca,ds_efectos,sel)
//				
//				total2 = ds_efectos.rowcount()
//				
//				for indice2 = 1 to total2
//					v_orden_efecto   = ds_efectos.object.efectoagrupa[indice2]
//					v_anyo_efecto    = ds_efectos.object.anyoagrupa[indice2]
//					v_importe_efecto = ds_efectos.object.importe[indice2]
//					
//					if isnull(v_importe_efecto) then
//						v_importe_efecto = 0
//					end if
//					
//					v_situacion_efecto = ""
//					setnull(v_fcobro_efecto)
//					
//					select situacion,            fcobro
//					into   :v_situacion_efecto, :v_fcobro_efecto
//					from   carefectos
//					where  empresa   = :codigo_empresa
//					and    orden     = :v_orden_efecto
//					and    anyo      = :v_anyo_efecto;
//					
//					if v_situacion_efecto <> "9" then
//						v_total_pendiente_factura = v_total_pendiente_factura + v_importe_efecto
//					end if
//				next
//				destroy ds_efectos				
						
			next			
			cb_1.enabled = false		
		end if
	end if
	tab_1.pendientes.dw_pendientes.setredraw(true)
	tab_1.asignadas.dw_asignadas.setredraw(true)	
end if

destroy ds_comisiones
end event

event modified;//string   sel, v_agente, codigo_agente, v_cliente, v_nombre_cliente
//long     indice, total, v_anyo, v_factura, v_linea, donde,veces = 0
//datetime v_ffra
//decimal  v_base_comision, v_comision_liquidada,v_comision_pendiente_cobro, v_comision
//
//datastore ds_comisiones
//
//veces ++
//
//if veces = 1 then
//	
//	tab_1.asignadas.dw_asignadas.reset()
//	
//	uo_agente.em_campo.text = f_nombre_agente_doc(codigo_empresa,long(em_anyo.text),long(em_documento.text))
//	uo_agente.em_codigo.text = f_agente_doc(codigo_empresa,long(em_anyo.text),long(em_documento.text))
//	em_fapunte.text = string(date(f_fecha_doc(codigo_empresa,long(em_anyo.text),long(em_documento.text))))
//	
//	if Trim(uo_agente.em_campo.text) = "" then 
//		if Trim(uo_agente.em_campo.text) <> "" Then f_activar_campo(em_documento)
//		em_documento.text = ""
//		em_fapunte.text   = ""
//		uo_agente.em_codigo.text = ""
//	end if
//	
//	cb_continuar.triggerevent(clicked!)
//	
//	if em_documento.text <> "" then
//		sel = " Select empresa,anyo,factura,linea,ffra,agente,baseliquipts,impfrapts,comisionliquipts,comision,cliente "+&
//				" from   carcomisiones "+&
//				" where  empresa         = '" + codigo_empresa + "' "+&
//				" and    doc_liquidacion = '" + em_documento.text + "' "+&
//				" and    fliquidacion    = '" + string(date(em_fapunte.text),formato_fecha_cursores) + "' " +&
//				" and    agente          = '" + uo_agente.em_codigo.text + "' "+&
//				" order  by anyo,factura "
//	//			" and    fliquidacion    = '"  + string(datetime(date(em_fapunte.text)),formato_fecha_cursores) +"'"
//	
//				
//		f_cargar_cursor_transaccion(sqlca,ds_comisiones,sel)		
//	
//		total = ds_comisiones.rowcount()
//		
//		tab_1.SelectTab(2)
//		tab_1.asignadas.dw_asignadas.setfocus()
//	
//		for indice = 1 to total
//			 v_anyo    = ds_comisiones.object.anyo[indice]
//			 v_factura = ds_comisiones.object.factura[indice]
//			 v_linea   = ds_comisiones.object.linea[indice]
//			 v_ffra    = ds_comisiones.object.ffra[indice]
//			 v_agente  = ds_comisiones.object.agente[indice]
//			 v_base_comision            = ds_comisiones.object.baseliquipts[indice]
//			 v_comision_pendiente_cobro = ds_comisiones.object.impfrapts[indice]
//			 v_comision_liquidada       = ds_comisiones.object.comisionliquipts[indice]
//			 v_comision                 = ds_comisiones.object.comision[indice]
//			 v_cliente                  = ds_comisiones.object.cliente[indice]
//			 v_nombre_cliente           = f_nombre_cliente(codigo_empresa,"C",v_cliente)
//	
//			 donde = tab_1.asignadas.dw_asignadas.insertrow(0)		 
//			 tab_1.asignadas.dw_asignadas.object.marca[donde]              = "S"
//			 tab_1.asignadas.dw_asignadas.object.empresa[donde]            = codigo_empresa
//			 tab_1.asignadas.dw_asignadas.object.anyo[donde]               = v_anyo		 
//			 tab_1.asignadas.dw_asignadas.object.factura[donde]            = v_factura
//			 tab_1.asignadas.dw_asignadas.object.linea[donde]              = v_linea
//			 tab_1.asignadas.dw_asignadas.object.ffra[donde]               = v_ffra
//			 tab_1.asignadas.dw_asignadas.object.agente[donde]             = v_agente
//			 tab_1.asignadas.dw_asignadas.object.razon[donde]              = v_nombre_cliente
//			 tab_1.asignadas.dw_asignadas.object.base_comision[donde]      = v_base_comision
//			 tab_1.asignadas.dw_asignadas.object.comision_pendiente_cobro[donde] = v_comision_pendiente_cobro		 
//			 tab_1.asignadas.dw_asignadas.object.comision_liquidada[donde] = v_comision_liquidada
//			 tab_1.asignadas.dw_asignadas.object.comision[donde]           = v_comision
//			 
//			 donde = tab_1.pendientes.dw_pendientes.insertrow(0)
//			 
//			 tab_1.pendientes.dw_pendientes.object.marca[donde]                  = "S"		 
//			 tab_1.pendientes.dw_pendientes.object.empresa[donde]	               = codigo_empresa
//			 tab_1.pendientes.dw_pendientes.object.anyo[donde]         	         = v_anyo		
//			 tab_1.pendientes.dw_pendientes.object.factura[donde]	               = v_factura
//			 tab_1.pendientes.dw_pendientes.object.linea[donde]           	      = v_linea		
//			 tab_1.pendientes.dw_pendientes.object.ffra[donde]	                  = v_ffra
//			 tab_1.pendientes.dw_pendientes.object.agente[donde]                 = v_agente
//			 tab_1.pendientes.dw_pendientes.object.genter_razon[donde]           = v_nombre_cliente
//			 tab_1.pendientes.dw_pendientes.object.carcomisiones_baseliquipts[donde] = v_base_comision
//			 tab_1.pendientes.dw_pendientes.object.comision[donde]	            = v_comision
//			 tab_1.pendientes.dw_pendientes.object.carcomisiones_pendiente_cobro_fra[donde] = v_comision_pendiente_cobro
//			 tab_1.pendientes.dw_pendientes.object.carcomisiones_comisionliquipts[donde]	  = v_comision_liquidada
//					
//		next
//		
//		cb_1.enabled = false
//	
//	end if
//end if
//destroy ds_comisiones
//
//uo_ejercicio.setfocus()
end event

type st_6 from statictext within w_liquidacion_comisiones
integer x = 2368
integer y = 136
integer width = 169
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_liquidacion_comisiones
integer x = 1513
integer y = 152
integer width = 251
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_liquidacion_comisiones
integer x = 1783
integer y = 152
integer width = 251
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_ffact_desde from u_em_campo within w_liquidacion_comisiones
integer x = 1509
integer y = 208
integer width = 261
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_ffact_hasta from u_em_campo within w_liquidacion_comisiones
integer x = 1778
integer y = 208
integer width = 261
integer taborder = 30
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type uo_agente from u_em_campo_2 within w_liquidacion_comisiones
integer x = 23
integer y = 212
integer width = 1161
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;em_documento.text = ""

uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)

If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	
	cb_1.enabled = true
	tab_1.pendientes.dw_pendientes.reset()
	tab_1.asignadas.dw_asignadas.reset()

	tab_1.SelectTab(1)
	tab_1.pendientes.dw_pendientes.setfocus()
	
	Return
end if 
//
//uo_agente.em_campo.text = f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)
//if Trim(uo_agente.em_campo.text) = "" then	
//	uo_agente.em_campo.text=""
//	uo_agente.em_codigo.text=""
//	uo_agente.em_campo.SetFocus()
//end if
//
//if em_documento.text <> "" then
//	em_documento.text = ""
//end if
//
//if (em_anyo.text = "" and em_documento.text = "") or (uo_agente.em_codigo.text = "") then	
//	
//	cb_1.enabled = true
//	tab_1.pendientes.dw_pendientes.reset()
//	tab_1.asignadas.dw_asignadas.reset()
//
//	tab_1.SelectTab(1)
//	tab_1.pendientes.dw_pendientes.setfocus()
//end if
//






end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Agentes"
ue_datawindow ="dw_ayuda_venagentes"
ue_filtro = ""
end event

on uo_agente.destroy
call u_em_campo_2::destroy
end on

type tab_1 from tab within w_liquidacion_comisiones
event create ( )
event destroy ( )
integer x = 18
integer y = 312
integer width = 3579
integer height = 1512
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 1
pendientes pendientes
asignadas asignadas
end type

on tab_1.create
this.pendientes=create pendientes
this.asignadas=create asignadas
this.Control[]={this.pendientes,&
this.asignadas}
end on

on tab_1.destroy
destroy(this.pendientes)
destroy(this.asignadas)
end on

type pendientes from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 3543
integer height = 1392
long backcolor = 80269524
string text = "Pendientes"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_pendientes dw_pendientes
end type

on pendientes.create
this.dw_pendientes=create dw_pendientes
this.Control[]={this.dw_pendientes}
end on

on pendientes.destroy
destroy(this.dw_pendientes)
end on

type dw_pendientes from u_datawindow within pendientes
integer y = 32
integer width = 3543
integer height = 1340
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_liquidacion_comisiones"
boolean vscrollbar = true
end type

event clicked;call super::clicked;long   indice,total
string marca

if dwo.name = "marcar"	 then
	if marcadas then
		marca = "N"
	else
		marca = "S"
	end if
	
	total = this.rowcount()
	
	for indice = 1 to total
		if this.object.marca[indice] <> marca then
			this.object.marca[indice] = marca
			this.event itemchanged(indice,this.object.marca,string(this.object.marca[indice]))	
		end if
	next
	marcadas = not(marcadas)
end if
end event

event itemchanged;long     indice,total,v_anyo_liquidacion, op2
string   seleccionado
decimal  v_impliquipts,v_impliqui
long     v_anyo,v_factura,v_linea,donde,donde2,documento
datetime v_ffra,v_fecha_liquidacion,v_fcobro
string   v_agente,sel,v_marca,v_cobrado,v_nacional,v_razon
decimal  v_base_comision,v_base_comision_divisa,v_comision,v_comision_pendiente_cobro,v_comision_liquidada,v_comision_liquidada_divisa
decimal v_impfrapts     
boolean  bien = true

if uo_agente.em_codigo.text <> "" then
	v_agente =	uo_agente.em_codigo.text
end if

documento           = long(em_documento.text)
v_fecha_liquidacion = datetime(date(em_fapunte.text))
v_anyo_liquidacion  = year(date(em_fapunte.text))

choose case  dwo.name 
	case "marca"
		seleccionado    = data	
		
		if seleccionado = "S" then
			donde = 0
			v_anyo                     = tab_1.pendientes.dw_pendientes.object.anyo[row]
			v_factura                  = tab_1.pendientes.dw_pendientes.object.factura[row]
			v_linea                    = tab_1.pendientes.dw_pendientes.object.linea[row]					
			v_ffra                     = tab_1.pendientes.dw_pendientes.object.ffra[row]
			v_agente                   = tab_1.pendientes.dw_pendientes.object.agente[row]
			v_razon                    = tab_1.pendientes.dw_pendientes.object.genter_razon[row]
			v_base_comision            = tab_1.pendientes.dw_pendientes.object.carcomisiones_baseliquipts[row]
			//v_base_comision_divisa     = tab_1.pendientes.dw_pendientes.object.carcomisiones_baseliqui[row]
			v_comision                 = tab_1.pendientes.dw_pendientes.object.comision[row]
			v_comision_pendiente_cobro = tab_1.pendientes.dw_pendientes.object.carcomisiones_pendiente_cobro_fra[row]
			v_comision_liquidada       = tab_1.pendientes.dw_pendientes.object.carcomisiones_comisionliquipts[row]
			//v_comision_liquidada_divisa= tab_1.pendientes.dw_pendientes.object.carcomisiones_comisionliqui[row]
			v_marca                    = "S"
			v_cobrado                  = tab_1.pendientes.dw_pendientes.object.cobrado[row]
			v_nacional                 = tab_1.pendientes.dw_pendientes.object.carcomisiones_nacional[row]
			v_fcobro                    = tab_1.pendientes.dw_pendientes.object.carcomisiones_fcobro[row]
			v_impfrapts              = tab_1.pendientes.dw_pendientes.object.impfrapts[row]
			// Avisamos si se han seleccionado comisiones que no se han cobrado	
			if (v_comision_pendiente_cobro <> 0) and (v_nacional = 'N') then
				op2 = messagebox("Atención","Se han seleccionado comisiones de extranjero que NO se han cobrado, ¿ Desea continuar ?",question!,yesno!,2)
				if op2 = 2 then
					return 2
				end if		
			end if
			
			if documento > 0 then
								
				update carcomisiones 
				set    liquidado = "S"  ,
						 importeliquidadopts            = :v_comision_liquidada,
						 carcomisiones.fliquidacion     = :v_fecha_liquidacion,
						 carcomisiones.doc_liquidacion  = :documento,
						 carcomisiones.anyo_liquidacion = :v_anyo_liquidacion
				where  carcomisiones.empresa = :codigo_empresa
				and    carcomisiones.anyo    = :v_anyo 
				and    carcomisiones.factura = :v_factura 
				and    carcomisiones.linea   = :v_linea;
	//  				 importeliquidado              = :v_comision_liquidada_divisa,
				
				if sqlca.sqlcode <> 0 then 
					f_mensaje("Error",SQLca.SqlErrText)
					rollback;
					return 2
				else
					if f_anyade_linea_doc_liquidacion(v_anyo_liquidacion,documento,v_anyo,v_factura,v_linea,v_comision_liquidada) then
						commit;
						donde = tab_1.asignadas.dw_asignadas.insertrow(0)						
					else
						rollback;
						return 2
					end if
				end if
			else
				donde = tab_1.asignadas.dw_asignadas.insertrow(0)				
			end if
			if donde > 0 then			
				tab_1.asignadas.dw_asignadas.object.empresa[donde]	                 = codigo_empresa
				tab_1.asignadas.dw_asignadas.object.anyo[donde]         	           = v_anyo		
				tab_1.asignadas.dw_asignadas.object.factura[donde]	                 = v_factura
				tab_1.asignadas.dw_asignadas.object.linea[donde]           	        = v_linea		
				tab_1.asignadas.dw_asignadas.object.ffra[donde]	                    = v_ffra
				tab_1.asignadas.dw_asignadas.object.agente[donde]                   = v_agente
				tab_1.asignadas.dw_asignadas.object.razon[donde]                    = v_razon
				tab_1.asignadas.dw_asignadas.object.base_comision[donde]	           = v_base_comision
				tab_1.asignadas.dw_asignadas.object.comision[donde]	              = v_comision
				tab_1.asignadas.dw_asignadas.object.comision_pendiente_cobro[donde] = v_comision_pendiente_cobro
				tab_1.asignadas.dw_asignadas.object.comision_liquidada[donde]	     = v_comision_liquidada
				tab_1.asignadas.dw_asignadas.object.marca[donde]	                 = v_marca
				tab_1.asignadas.dw_asignadas.object.cobrado[donde]	                 = v_cobrado
				tab_1.asignadas.dw_asignadas.object.nacional[donde]	              = v_nacional
				tab_1.asignadas.dw_asignadas.object.fcobro[donde]	              = v_fcobro
				tab_1.asignadas.dw_asignadas.object.impfrapts[donde]	         = v_impfrapts
				
				tab_1.asignadas.dw_asignadas.setsort("factura")
				tab_1.asignadas.dw_asignadas.sort()
			end if
		else
			
			v_anyo               = tab_1.pendientes.dw_pendientes.object.anyo[row]
			v_factura            = tab_1.pendientes.dw_pendientes.object.factura[row]
			v_linea              = tab_1.pendientes.dw_pendientes.object.linea[row]					
			v_comision_liquidada = tab_1.pendientes.dw_pendientes.object.carcomisiones_comisionliquipts[row]
	
			update carcomisiones 
			set    liquidado = "N"  ,
					 importeliquidadopts            = 0,
					 importeliquidado               = 0,
					 carcomisiones.fliquidacion     = "",
					 carcomisiones.doc_liquidacion  = 0,
					 carcomisiones.anyo_liquidacion = 0
			where  carcomisiones.empresa = :codigo_empresa
			and    carcomisiones.anyo    = :v_anyo 
			and    carcomisiones.factura = :v_factura 
			and    carcomisiones.linea   = :v_linea;
			
			if sqlca.sqlcode <> 0 then 				
				f_mensaje("Error",SQLca.SqlErrText)	
				rollback;
				return 2
			else
				if documento > 0 then
					if f_borra_linea_doc_liquidacion(v_anyo_liquidacion,documento,v_anyo,v_factura,v_linea,v_comision_liquidada) then
						commit;
						sel = "empresa = '"+codigo_empresa+"' "
						sel = sel +"and anyo    = "+string(v_anyo,"###0")+" "
						sel = sel +"and factura = "+string(v_factura,"######0")+" "
						sel = sel +"and linea   = "+string(v_linea,"####0")+" "
				
						donde = tab_1.asignadas.dw_asignadas.find(sel,1,tab_1.asignadas.dw_asignadas.rowcount())
						
						if donde > 0 then
							tab_1.asignadas.dw_asignadas.deleterow(donde)
						end if				
					else
						rollback;
						return 2
					end if
				else
					commit;
					sel = "empresa = '"+codigo_empresa+"' "
					sel = sel +"and anyo    = "+string(v_anyo,"###0")+" "
					sel = sel +"and factura = "+string(v_factura,"######0")+" "
					sel = sel +"and linea   = "+string(v_linea,"####0")+" "
			
					donde = tab_1.asignadas.dw_asignadas.find(sel,1,tab_1.asignadas.dw_asignadas.rowcount())
					
					if donde > 0 then
						tab_1.asignadas.dw_asignadas.deleterow(donde)
					end if									
				end if
			end if				
		end if

end choose
end event

type asignadas from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 3543
integer height = 1392
long backcolor = 80269524
string text = "Asignadas"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_asignadas dw_asignadas
end type

on asignadas.create
this.dw_asignadas=create dw_asignadas
this.Control[]={this.dw_asignadas}
end on

on asignadas.destroy
destroy(this.dw_asignadas)
end on

type dw_asignadas from datawindow within asignadas
integer y = 8
integer width = 3543
integer height = 1384
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_liquidacion_comisiones_liquidadas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;long     v_anyo,v_factura,v_linea,donde_asignadas,donde_pendientes,documento,v_anyo_liquidacion
dec      v_comision_liquidada
string   sel
datetime v_fecha_liquidacion

documento           = long(em_documento.text)
v_fecha_liquidacion = datetime(date(em_fapunte.text))
v_anyo_liquidacion  = year(date(em_fapunte.text))	
	
v_anyo    = tab_1.asignadas.dw_asignadas.object.anyo[row]
v_factura = tab_1.asignadas.dw_asignadas.object.factura[row]
v_linea   = tab_1.asignadas.dw_asignadas.object.linea[row]					
v_comision_liquidada = tab_1.asignadas.dw_asignadas.object.carcomisiones_comision_liquidada[row]

sel = "empresa = '"+codigo_empresa+"' "
sel = sel +"and anyo    = "+string(v_anyo,"###0")+" "
sel = sel +"and factura = "+string(v_factura,"######0")+" "
sel = sel +"and linea   = "+string(v_linea,"####0")+" "

donde_pendientes  = tab_1.pendientes.dw_pendientes.find(sel,1,tab_1.pendientes.dw_pendientes.rowcount())
donde_asignadas   = tab_1.asignadas.dw_asignadas.find(sel,1,tab_1.asignadas.dw_asignadas.rowcount())
		
if donde_asignadas > 0 and donde_pendientes > 0 then	
	update carcomisiones 
	set    liquidado = "N"  ,
			 importeliquidadopts            = 0,
			 importeliquidado               = 0,
			 carcomisiones.fliquidacion     = "",
			 carcomisiones.doc_liquidacion  = 0,
			 carcomisiones.anyo_liquidacion = 0
	where  carcomisiones.empresa = :codigo_empresa
	and    carcomisiones.anyo    = :v_anyo 
	and    carcomisiones.factura = :v_factura 
	and    carcomisiones.linea   = :v_linea;
	
	if sqlca.sqlcode <> 0 then 
		f_mensaje("Error",SQLca.SqlErrText)
		rollback;
		return 2
	else
		if documento > 0 then
			if f_borra_linea_doc_liquidacion(v_anyo_liquidacion,documento,v_anyo,v_factura,v_linea,v_comision_liquidada) then
				commit;
				tab_1.asignadas.dw_asignadas.deleterow(donde_asignadas)
				tab_1.pendientes.dw_pendientes.object.marca[donde_pendientes] = "N"				
			else
				rollback;
				return 2
			end if
		else
			commit;
			tab_1.asignadas.dw_asignadas.deleterow(donde_asignadas)
			tab_1.pendientes.dw_pendientes.object.marca[donde_pendientes] = "N"			
		end if
	end if
else
	return 2
end if


end event

type gb_1 from groupbox within w_liquidacion_comisiones
integer x = 9
integer y = 100
integer width = 1472
integer height = 208
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type cbx_cabecera from checkbox within w_liquidacion_comisiones
integer x = 3269
integer y = 300
integer width = 306
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cabecera"
boolean checked = true
boolean lefttext = true
end type


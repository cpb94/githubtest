$PBExportHeader$w_cancelacion_riesgos.srw
$PBExportComments$€ Cancelacion efectos sit = 5 de Nacional
forward
global type w_cancelacion_riesgos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_cancelacion_riesgos
end type
type cb_procesar from commandbutton within w_cancelacion_riesgos
end type
type st_2 from statictext within w_cancelacion_riesgos
end type
type em_hasta from editmask within w_cancelacion_riesgos
end type
type cb_continuar from commandbutton within w_cancelacion_riesgos
end type
type gb_2 from groupbox within w_cancelacion_riesgos
end type
type st_1 from statictext within w_cancelacion_riesgos
end type
type dw_cursor_agrupados from datawindow within w_cancelacion_riesgos
end type
type uo_banco from u_em_campo_2 within w_cancelacion_riesgos
end type
type st_22 from statictext within w_cancelacion_riesgos
end type
type gb_3 from groupbox within w_cancelacion_riesgos
end type
type uo_ejercicio from u_ejercicio within w_cancelacion_riesgos
end type
type dw_listado from datawindow within w_cancelacion_riesgos
end type
type pb_2 from upb_imprimir within w_cancelacion_riesgos
end type
type dw_detalle from datawindow within w_cancelacion_riesgos
end type
end forward

global type w_cancelacion_riesgos from w_int_con_empresa
integer x = 27
integer y = 4
integer width = 4343
integer height = 3140
pb_1 pb_1
cb_procesar cb_procesar
st_2 st_2
em_hasta em_hasta
cb_continuar cb_continuar
gb_2 gb_2
st_1 st_1
dw_cursor_agrupados dw_cursor_agrupados
uo_banco uo_banco
st_22 st_22
gb_3 gb_3
uo_ejercicio uo_ejercicio
dw_listado dw_listado
pb_2 pb_2
dw_detalle dw_detalle
end type
global w_cancelacion_riesgos w_cancelacion_riesgos

type variables
str_contaapun apu

str_paramemp em
string is_naci_extra,is_nacional
end variables

forward prototypes
public subroutine f_control (datawindow data)
public function boolean f_grabar_apuntes_banco_rem_dto (string banco, decimal impban, integer registro)
public function boolean f_grabar_apuntes_clientes (decimal totrem, string arg_cliente, integer registro)
public function boolean f_grabar_apuntes_cli_rem_dto (decimal totrem, string arg_cliente, integer registro)
public function boolean f_grabar_apuntes_cli_rem_gc (decimal totrem, string arg_cliente, integer registro)
public function boolean f_grabar_apuntes_banco_rem_gc (string banco, decimal impban, integer registro)
end prototypes

public subroutine f_control (datawindow data);Long		registros
string banco
integer dias_riesgo

dias_riesgo = em.dias_riesgo
if isnull(dias_riesgo) then dias_riesgo = 0


IF Year(Date(em_hasta.text)) <> Dec(uo_ejercicio.em_ejercicio.text) THEN
	Messagebox("ERROR","El ejercicio contable no se corresponde con la Fecha",Exclamation!)
	f_activar_campo(em_hasta)
ELSE
	if uo_banco.em_codigo.text = "" then
		banco = "%"

	else
		banco = uo_banco.em_codigo.text

	end if
	
	registros = data.Retrieve(codigo_empresa,datetime(date(em_hasta.text)),banco,dias_riesgo,is_nacional)

	IF registros > 0 THEN
		data.visible  = TRUE
		cb_procesar.enabled = TRUE
	ELSE
		data.visible  = FALSE
		cb_procesar.enabled = FALSE
	END IF
END IF


end subroutine

public function boolean f_grabar_apuntes_banco_rem_dto (string banco, decimal impban, integer registro);String 	cta_gene
Boolean	bien


apu.cuenta		=  f_cta_riesgo_carbancos(codigo_empresa,banco)
apu.documento  =  dw_detalle.GetItemstring(registro,"factura")	

apu.concepto	=	f_concepto_contagene(codigo_empresa,"20")	

//apu.origen		=	f_diario_contagene(codigo_empresa,"20")	

if f_dh_contagene(codigo_empresa,"20")= "D" then
	apu.debe		=	impban
	apu.haber	=	0
else
	apu.debe		=	0
	apu.haber	=	impban
end if	

apu.apunte			=	apu.apunte + 1
apu.orden_apunte	=	apu.apunte

bien = f_insert_contaapun(apu) 

RETURN bien


end function

public function boolean f_grabar_apuntes_clientes (decimal totrem, string arg_cliente, integer registro);String 	cta_gene
Boolean	bien

cta_gene			=	f_cuenta_contagene(codigo_empresa,"21")
apu.cuenta 		=	f_comp_cta_riesgo(cta_gene,arg_cliente)
apu.documento  =  dw_detalle.GetItemstring(registro,"factura")	
apu.concepto	=	f_concepto_contagene(codigo_empresa,"21")

//apu.origen		=	f_diario_contagene(codigo_empresa,"21")	

if f_dh_contagene(codigo_empresa,"21")= "D" then
	apu.debe		=	totrem
	apu.haber	=	0
else
	apu.debe		=	0
	apu.haber	=	totrem
end if	

apu.apunte			=	apu.apunte + 1
apu.orden_apunte	=	apu.apunte

bien = f_insert_contaapun(apu) 

RETURN bien




end function

public function boolean f_grabar_apuntes_cli_rem_dto (decimal totrem, string arg_cliente, integer registro);String 	cta_gene
Boolean	bien

cta_gene			=	f_cuenta_contagene(codigo_empresa,"21")
apu.cuenta 		=	f_venclientes_cuenta_ecd(codigo_empresa,arg_cliente)//f_comp_cta_riesgo_431x(cta_gene,arg_cliente)
apu.documento  =  dw_detalle.GetItemstring(registro,"factura")	
apu.concepto	=	f_concepto_contagene(codigo_empresa,"21")

//apu.origen		=	f_diario_contagene(codigo_empresa,"21")	

if f_dh_contagene(codigo_empresa,"21")= "D" then
	apu.debe		=	totrem
	apu.haber	=	0
else
	apu.debe		=	0
	apu.haber	=	totrem
end if	

apu.apunte			=	apu.apunte + 1
apu.orden_apunte	=	apu.apunte

bien = f_insert_contaapun(apu) 

RETURN bien




end function

public function boolean f_grabar_apuntes_cli_rem_gc (decimal totrem, string arg_cliente, integer registro);String 	cta_gene
Boolean	bien

cta_gene			=	f_cuenta_contagene(codigo_empresa,"57")
//Lo quitamos el 30-01-2017 Paco Marin
//f_venclientes_cuenta_ecgc(codigo_empresa,arg_cliente)
//Lo quitamos el 30-01-2017 Paco Marin
apu.cuenta 		=	f_cuenta_genter(codigo_empresa,"C",arg_cliente)
apu.documento  =  dw_detalle.GetItemstring(registro,"factura")	
apu.concepto	=	f_concepto_contagene(codigo_empresa,"57")

//apu.origen		=	f_diario_contagene(codigo_empresa,"21")	

if f_dh_contagene(codigo_empresa,"57")= "D" then
	apu.debe		=	totrem
	apu.haber	=	0
else
	apu.debe		=	0
	apu.haber	=	totrem
end if	

apu.apunte			=	apu.apunte + 1
apu.orden_apunte	=	apu.apunte

bien = f_insert_contaapun(apu) 

RETURN bien




end function

public function boolean f_grabar_apuntes_banco_rem_gc (string banco, decimal impban, integer registro);String 	cta_gene
Boolean	bien


apu.cuenta		=  f_cuenta_carbancos(codigo_empresa,banco)
apu.documento  =  dw_detalle.GetItemstring(registro,"factura")	

apu.concepto	=	f_concepto_contagene(codigo_empresa,"20")	

//apu.origen		=	f_diario_contagene(codigo_empresa,"20")	

if f_dh_contagene(codigo_empresa,"20")= "D" then
	apu.debe		=	impban
	apu.haber	=	0
else
	apu.debe		=	0
	apu.haber	=	impban
end if	

apu.apunte			=	apu.apunte + 1
apu.orden_apunte	=	apu.apunte

bien = f_insert_contaapun(apu) 

RETURN bien


end function

event open;call super::open;istr_parametros.s_titulo_ventana="Cancelación de Riesgos"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_detalle.visible=false
cb_procesar.enabled=false
em_hasta.text=string(today(),"dd-mm-yy")
uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))

em_hasta.setfocus()


em = f_paramemp(codigo_empresa)

is_naci_extra = 'N'
is_nacional = 'S'
end event

on w_cancelacion_riesgos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_procesar=create cb_procesar
this.st_2=create st_2
this.em_hasta=create em_hasta
this.cb_continuar=create cb_continuar
this.gb_2=create gb_2
this.st_1=create st_1
this.dw_cursor_agrupados=create dw_cursor_agrupados
this.uo_banco=create uo_banco
this.st_22=create st_22
this.gb_3=create gb_3
this.uo_ejercicio=create uo_ejercicio
this.dw_listado=create dw_listado
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_procesar
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_hasta
this.Control[iCurrent+5]=this.cb_continuar
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.dw_cursor_agrupados
this.Control[iCurrent+9]=this.uo_banco
this.Control[iCurrent+10]=this.st_22
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.uo_ejercicio
this.Control[iCurrent+13]=this.dw_listado
this.Control[iCurrent+14]=this.pb_2
this.Control[iCurrent+15]=this.dw_detalle
end on

on w_cancelacion_riesgos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_procesar)
destroy(this.st_2)
destroy(this.em_hasta)
destroy(this.cb_continuar)
destroy(this.gb_2)
destroy(this.st_1)
destroy(this.dw_cursor_agrupados)
destroy(this.uo_banco)
destroy(this.st_22)
destroy(this.gb_3)
destroy(this.uo_ejercicio)
destroy(this.dw_listado)
destroy(this.pb_2)
destroy(this.dw_detalle)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cancelacion_riesgos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cancelacion_riesgos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cancelacion_riesgos
integer x = 5
integer width = 4233
end type

type pb_1 from upb_salir within w_cancelacion_riesgos
integer x = 4110
integer y = 92
integer width = 128
integer height = 112
integer taborder = 0
end type

type cb_procesar from commandbutton within w_cancelacion_riesgos
event clicked pbm_bnclicked
integer x = 1504
integer y = 216
integer width = 439
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Procesar"
end type

event clicked;Long 		registros,hay,primer_asiento
Integer 	i,bien,opci
Dec{0}	anyo_efecto,orden_efecto,linea_efecto
dec      impban,totrem,importe
String	oldban,ban,marca2,var_cliente,var_tipo_remesa
DateTime	f_contable
Boolean	vale,marcados

str_carhistorico historico


opci = messagebox("Atención","¿ Desea cancelar el riesgo de los efectos seleccionados ?",question!,yesno!,2)
if opci = 2 then return


marcados = false
for i = 1 to dw_detalle.rowcount()
	marca2 = dw_detalle.getitemstring(i,"punteado")
	if marca2 = "S" then marcados = true 
next
if marcados = false then 
	messagebox("Atención","No se han seleccionado efectos")
	return
end if


registros	= dw_detalle.rowcount()
//f_contable 	= DateTime(date(em_hasta.text))
totrem		= 0
impban		= 0

// Cojo numero de asiento para todo el proceso
// Datos comunes a todos los apuntes

//apu.apunte		=	0	// inicialmente 0, se incrementa con cada apunte
apu.ejercicio 	=	Dec(uo_ejercicio.em_ejercicio.text)
apu.empresa 	=	codigo_empresa
apu.origen		=	f_diario_contagene(codigo_empresa,"20")	
//apu.asiento		=	f_ultimo_asiento(apu.ejercicio,codigo_empresa,month(date(f_contable)),apu.origen)
//apu.fapunte		=	f_contable
	
setnull(apu.diario)
Setnull(apu.tipoapu)
setnull(apu.documento)
setnull(apu.factura)
setnull(apu.ffactura)
setnull(apu.imponible)
setnull(apu.tipoiva)
setnull(apu.iva)
setnull(apu.divisas)
setnull(apu.deducible)
setnull(apu.actualizado)
setnull(apu.listado)
setnull(apu.registro)

setnull(apu.tipoter)
setnull(apu.clipro)
setnull(apu.conciliado)
setnull(apu.nif)
setnull(apu.punteado)
// la fvalor es la fapunte
setnull(apu.docpunteo)
setnull(apu.coste)
setnull(apu.fregistro)

apu.cambio	=	1
apu.moneda	=	f_moneda_empresa(codigo_empresa)


string marca
boolean primero
dec      divisas_efecto,cambio_cobro
//long     anyo_efecto,orden_efecto
string   banco
datetime fecha_cobro

primero = true
primer_asiento = 0

FOR i=1 TO registros
	bien = 0	
	marca = dw_detalle.getitemstring(i,"punteado")
	if marca = "N" then continue
		
	anyo_efecto	= dw_detalle.GetItemnumber(i,"anyo")
	orden_efecto= dw_detalle.GetItemnumber(i,"carefectos_orden")
	ban			= dw_detalle.GetItemString(i,"banco")

	divisas_efecto = dw_detalle.object.divisas[i]
	banco          = dw_detalle.object.banco[i]
	cambio_cobro   = dw_detalle.object.cambio[i]
	fecha_cobro    = dw_detalle.object.fecha_cobro[i]
	
	if not(f_cobrar_efecto(codigo_empresa,anyo_efecto,orden_efecto,divisas_efecto,cambio_cobro,fecha_cobro,banco)) then
		//lb_correcto = false
		bien = 1
	end if	

//Viejo 11-12-2017 Paco Marin 		
////	if primero then 
////		primero = false
////		oldban = ban
////	end if
////	
////	IF oldban <> ban THEN
////		vale = f_grabar_apuntes_banco_rem_dto(oldban,impban)
////		impban = 0
////		IF Not vale THEN
////			bien = 1
////			EXIT
////		END IF
////	END IF
//	// Selecciono datos del efecto y los inserto en carhistorico
//	  SELECT 
//		carefectos.anyofra,carefectos.factura,carefectos.recibo,
//		carefectos.fvto, carefectos.ffra, carefectos.fvto_original, 
//		carefectos.importe,carefectos.divisas,carefectos.monedas,
//		carefectos.fpago,carefectos.tipodoc,carefectos.banco,   
//		carefectos.remesa,carefectos.fremesa,
//		carefectos.agente1,carefectos.pais,carefectos.cuenta,   
//		carefectos.domiciliacion,carefectos.Nacional,
//		carefectos.observaciones,carefectos.libre,carefectos.gasto,   
//		carefectos.fdevolucion,carefectos.agrupado,   
//		carefectos.efectoagrupa,carefectos.anyoagrupa,
//		carefectos.cliente,carefectos.anyo_remesa, fecha_recibido, banco_docu  
//    INTO :historico.anyofra,:historico.factura,:historico.recibo,   
//		:historico.fvto,:historico.ffra, :historico.fvto_original, 
//		:historico.importe,:historico.divisas,:historico.monedas,   
//		:historico.fpago,:historico.tipodoc,:historico.banco,   
//		:historico.remesa,:historico.fremesa,  
//		:historico.agente1,:historico.pais,:historico.cuenta,   
//		:historico.domiciliacion,:historico.nacional,   
//		:historico.observaciones,:historico.libre,:historico.gasto,   
//		:historico.fdevolucion,:historico.agrupado,
//		:historico.efectoagrupa,:historico.anyoagrupa,   
//		:historico.cliente,:historico.anyo_remesa, 
//		:historico.fecha_recibido, :historico.banco_docu
//   FROM carefectos  
//   WHERE ( carefectos.empresa = :codigo_empresa ) AND  
//         ( carefectos.anyo 	= :anyo_efecto ) AND  
//         ( carefectos.orden 	= :orden_efecto )   ;
//	IF SQLCA.SQLCODE <> 0 Then bien = 1		
//	historico.empresa=codigo_empresa
//	historico.anyo=anyo_efecto 
//	historico.orden=orden_efecto
//	historico.fcobro= dw_detalle.object.fecha_cobro[i] //historico.fvto
//	historico.situacion="9"     //COBRADO
//	SELECT max(carhistorico.linea ) INTO :linea_efecto FROM carhistorico  
//   WHERE ( carhistorico.empresa 	= :codigo_empresa ) AND  
//         ( carhistorico.anyo 		= :anyo_efecto ) AND  
//         ( carhistorico.orden 	= :orden_efecto ) USING SQLCA;
//	if sqlca.sqlcode=100 then linea_efecto=0
//	if isnull(linea_efecto) then linea_efecto=0
//	historico.linea=linea_efecto + 1
//	
//	if not f_insert_carhistorico(historico) then bien=1
//
//	// Borro el efecto de carefectos
//	DELETE FROM carefectos  
//   WHERE ( carefectos.empresa = :codigo_empresa ) AND  
//         ( carefectos.anyo 	= :anyo_efecto ) AND  
//         ( carefectos.orden 	= :orden_efecto ) USING SQLCA;
//	IF SQLCA.SQLCODE <> 0 Then bien = 1
//	
//	// Busco si hay mas efectos con ese nº de remesa. En caso de ser el
//	// último pongo carremesas en situacion de cancelada
//	SELECT Count(*) INTO :hay FROM carefectos
//	WHERE carefectos.empresa 		= :codigo_empresa
//	AND   carefectos.banco	 		= :historico.banco
//	AND   carefectos.anyo_remesa 	= :historico.anyo_remesa
//	AND   carefectos.remesa			= :historico.remesa;
//	
//	IF IsNull(hay) THEN hay = 0
//	
//	IF hay = 0 THEN
//		UPDATE carremesas SET carremesas.situacion = '5'
//		WHERE carremesas.empresa		= :codigo_empresa
//		AND   carremesas.anyo			= :historico.anyo_remesa
//		AND   carremesas.banco			= :historico.banco
//		AND   carremesas.naci_extra 	= :is_naci_extra
//		AND   carremesas.remesa			= :historico.remesa;
//	END IF
//	
//	// Si el efecto es agrupado proceso el detalle
//	if historico.agrupado="S" then
//		//selecciono detalle del registro agrupado
//
//		integer det_registros
//		
//		dw_cursor_agrupados.SetTransObject(SQLCA)
//		dw_cursor_agrupados.retrieve(codigo_empresa,anyo_efecto,orden_efecto)
//		det_registros=dw_cursor_agrupados.rowcount()
//				// Selecciono datos del efecto y los inserto en carhistorico
//		integer r
//		dec det_anyo_efecto,det_orden_efecto,det_linea_efecto
//		
//		str_carhistorico det_historico
//		for r=1 to det_registros
//			det_anyo_efecto  =dw_cursor_agrupados.GetItemNumber(r,"anyo")
//			det_orden_efecto =dw_cursor_agrupados.GetItemNumber(r,"orden")
//	  		
//	  		SELECT 
//				carefectos.anyofra,carefectos.factura,carefectos.recibo,
//				carefectos.fvto, carefectos.ffra, carefectos.fvto_original, 
//				carefectos.importe,carefectos.divisas,carefectos.monedas,
//				carefectos.fpago,carefectos.tipodoc,carefectos.banco,   
//				carefectos.remesa,carefectos.fremesa,
//				carefectos.agente1,carefectos.pais,carefectos.cuenta,   
//				carefectos.domiciliacion,carefectos.Nacional,
//				carefectos.observaciones,carefectos.libre,carefectos.gasto,   
//				carefectos.fdevolucion,carefectos.agrupado,   
//				carefectos.efectoagrupa,carefectos.anyoagrupa,
//				carefectos.cliente,carefectos.anyo_remesa  
//    		INTO
//			:det_historico.anyofra,:det_historico.factura,:det_historico.recibo,   
//			:det_historico.fvto,:det_historico.ffra, :det_historico.fvto_original, 
//			:det_historico.importe,:det_historico.divisas,:det_historico.monedas,   
//			:det_historico.fpago,:det_historico.tipodoc,:det_historico.banco,   
//			:det_historico.remesa,:det_historico.fremesa,  
//			:det_historico.agente1,:det_historico.pais,:det_historico.cuenta,   
//			:det_historico.domiciliacion,:det_historico.nacional,   
//			:det_historico.observaciones,:det_historico.libre,:det_historico.gasto,   
//			:det_historico.fdevolucion,:det_historico.agrupado,
//			:det_historico.efectoagrupa,:det_historico.anyoagrupa,   
//			:det_historico.cliente,:det_historico.anyo_remesa  
//    		FROM carefectos  
//   		WHERE ( carefectos.empresa = :codigo_empresa ) AND  
//        			( carefectos.anyo  = :det_anyo_efecto ) AND  
//         		( carefectos.orden = :det_orden_efecto ) USING SQLCA;
//			IF SQLCA.SQLCODE <> 0 Then bien = 1
//			det_historico.empresa=codigo_empresa
//			det_historico.anyo=det_anyo_efecto 
//			det_historico.orden=det_orden_efecto
//			det_historico.fcobro=historico.fcobro
//			det_historico.situacion="3"
//
//			SELECT max(carhistorico.linea )  
//			INTO :det_linea_efecto  
//			FROM carhistorico  
//			WHERE ( carhistorico.empresa = :codigo_empresa ) AND  
//					( carhistorico.anyo = :det_anyo_efecto ) AND  
//					( carhistorico.orden = :det_orden_efecto ) USING SQLCA;
//					
//			if sqlca.sqlcode=100 then det_linea_efecto=0
//			if isnull(det_linea_efecto) then det_linea_efecto=0
//			det_historico.linea=det_linea_efecto + 1
//			det_historico.cambio_cobro = det_historico.cambio
//			if not f_insert_carhistorico(det_historico) then bien=1
//					
//			// borro el detalle de carefectos
//
//			DELETE FROM carefectos  
//			WHERE ( carefectos.empresa = :codigo_empresa ) AND  
//					( carefectos.anyo 	= :det_anyo_efecto) AND  
//					( carefectos.orden 	= :det_orden_efecto ) USING SQLCA;
//					
//			IF SQLCA.SQLCODE <> 0 Then bien = 1
//		next
//		
//	end if

	oldban = ban
	importe = dw_detalle.GetItemNumber(i,"importe")
	
	IF IsNull(importe) THEN importe = 0
	impban = impban + importe
	totrem = totrem + importe
	
	apu.fapunte		=	dw_detalle.object.fecha_cobro[i]//dw_detalle.GetItemdatetime(i,"fvto")
	apu.mes		   =	month(date(apu.fapunte))
	apu.asiento		=	f_ultimo_asiento(apu.ejercicio,codigo_empresa,month(date(apu.fapunte)),apu.origen)
	apu.apunte		=	0
	apu.fvalor	   =  apu.fapunte
	apu.ampliacion	=	"Vto "+string(dw_detalle.GetItemdatetime(i,"fvto"),"dd/mm/yy")+" Fra "+&
							dw_detalle.GetItemstring(i,"factura")+" Rem "+string(dw_detalle.GetItemnumber(i,"remesa"),"###,###")
	var_cliente    =  dw_detalle.GetItemString(i,"cliente")
	//var_cliente    =  dw_detalle.GetItemString(i,"cuenta")
	var_tipo_remesa = dw_detalle.GetItemString(i,"tipo_remesa")
	
	if var_tipo_remesa = "1" then
   	vale = f_grabar_apuntes_cli_rem_dto(importe,var_cliente,i)
	else
		vale = f_grabar_apuntes_cli_rem_gc(importe,var_cliente,i)
	end if
	
	IF Not vale THEN bien = 1
	if var_tipo_remesa = "1" then
   	vale = f_grabar_apuntes_banco_rem_dto(ban,importe,i)
	else
		vale = f_grabar_apuntes_banco_rem_gc(ban,importe,i)
	end if
	IF Not vale THEN bien = 1
	
	If bien <> 0  Then
		RollBack;
		f_mensaje("Error en proceso","El proceso no se actualiza(" +sqlca.sqlerrtext+")")
	ELSE
		Commit;
		if primer_asiento = 0 then
			primer_asiento = apu.asiento
		end if
	END IF	
	
next

f_control(dw_detalle)
f_mensaje("Proceso de cancelacion de riesgos","El primer asiento generado es "+ String(primer_asiento,"####,##0"))

//Viejo 11-12-2017 Paco Marin 		
////IF bien = 0 THEN
////	vale = f_grabar_apuntes_banco_rem_dto(oldban,impban)
////	IF Not vale THEN 
////		bien = 1
////	ELSE
//////		vale = f_grabar_apuntes_clientes(totrem)
//////		IF Not vale THEN bien = 1
////	END IF
////END IF
//	
//
//
//
//// ************************************************************************+
//// CONTROL DE COMISIONES
//// ************************************************************************+ 
//string factur
//long cuantos_recibos
//dec anyo_fac,fac
//
//bien = 0
//// COMPRUEBO SI QUEDA ALGÚN RECIBO EN CARTERA PARA DARLO COMO COBRADO EN CARCOMISIONES
//FOR i=1 TO registros
//	
//	anyo_fac = dw_detalle.GetItemnumber(i,"anyo")
//	factur = dw_detalle.GetItemstring(i,"factura")
//	
//	SELECT COUNT(carefectos.recibo)  
//	INTO :cuantos_recibos  
//	FROM carefectos  
//	WHERE ( carefectos.empresa = :codigo_empresa ) AND  
//			( carefectos.anyofra = :anyo_fac ) AND  
//			( carefectos.factura = :factur)   ;
//		 
//	if sqlca.sqlcode=100 or cuantos_recibos=0 or isnull(cuantos_recibos) then
//		// PASO A CARCOMISIONES COMO COBRADO
//
//		fac=Dec(factur)
//		
//		Update carcomisiones 
//			Set    carcomisiones.cobrado = 'S', carcomisiones.fcobro = :historico.fcobro
//					 
//			Where  carcomisiones.empresa = :codigo_empresa
//			ANd    carcomisiones.anyo    = :anyo_fac
//			And    carcomisiones.factura = :fac;
//
//		IF SQLCA.SQLCODE <> 0 Then bien = 1			
//		
//	
//	end if	
//	
//
//next
//
//
//if bien = 0 then
//	COMMIT;
//	f_control(dw_detalle)
//ELSE
//	ROLLBACK;
//end if
//f_mensaje("Proceso de cancelacion de riesgos","El primer asiento generado es "+ String(primer_asiento,"####,##0"))



end event

type st_2 from statictext within w_cancelacion_riesgos
boolean visible = false
integer x = 5
integer y = 1372
integer width = 2011
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Recibos para Cancelacion de Riesgos        ¿Procesar o Salir?"
boolean focusrectangle = false
end type

type em_hasta from editmask within w_cancelacion_riesgos
integer x = 576
integer y = 120
integer width = 311
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

event modified;//f_control()
end event

type cb_continuar from commandbutton within w_cancelacion_riesgos
integer x = 1504
integer y = 120
integer width = 325
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Continuar"
end type

event clicked;f_control(dw_detalle)
end event

type gb_2 from groupbox within w_cancelacion_riesgos
integer x = 14
integer y = 76
integer width = 1449
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_1 from statictext within w_cancelacion_riesgos
integer x = 64
integer y = 128
integer width = 480
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Hasta F. Vencim. :"
boolean focusrectangle = false
end type

type dw_cursor_agrupados from datawindow within w_cancelacion_riesgos
boolean visible = false
integer x = 1970
integer y = 104
integer width = 914
integer height = 156
string dataobject = "dw_proceso_detalle_agrupados"
boolean livescroll = true
end type

type uo_banco from u_em_campo_2 within w_cancelacion_riesgos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 288
integer y = 248
integer width = 1083
integer height = 80
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_banco.em_campo.text=f_nombre_banco(codigo_empresa,uo_banco.em_codigo.text)
If Trim(uo_banco.em_campo.text)="" then
	uo_banco.em_campo.text=""
	uo_banco.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Banco"
ue_datawindow ="dw_ayuda_carbancos"

end event

on uo_banco.destroy
call u_em_campo_2::destroy
end on

type st_22 from statictext within w_cancelacion_riesgos
integer x = 64
integer y = 252
integer width = 215
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Banco :"
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_cancelacion_riesgos
integer x = 9
integer y = 196
integer width = 1454
integer height = 156
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_ejercicio from u_ejercicio within w_cancelacion_riesgos
integer x = 3278
integer y = 104
integer taborder = 50
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_listado from datawindow within w_cancelacion_riesgos
boolean visible = false
integer x = 2459
integer y = 20
integer width = 46
integer height = 36
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_cancelacion_riesgos"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_cancelacion_riesgos
integer x = 1829
integer y = 120
end type

event clicked;call super::clicked;//f_control(dw_listado)
//f_imprimir_datawindow(dw_listado)

u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = uo_banco.em_campo.text
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

//Con esto forzamos a que el reporte se ajuste al tamaño del papel
//dw_detalle.Object.DataWindow.Zoom = 100//75

u_imp.event ue_imprimir(dw_detalle)

destroy u_imp

//dw_detalle.Object.DataWindow.Zoom = 133//100

end event

type dw_detalle from datawindow within w_cancelacion_riesgos
integer x = 9
integer y = 372
integer width = 4315
integer height = 2556
string dataobject = "dw_cancelacion_riesgos"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;long i

if dwo.name = "marcar" then
	for i = 1 to dw_detalle.rowcount()	
		dw_detalle.setitem(i,"punteado","S")	
	next
end if


if dwo.name = "desmarcar" then
	for i = 1 to dw_detalle.rowcount()	
		dw_detalle.setitem(i,"punteado","N")	
	next
end if
end event


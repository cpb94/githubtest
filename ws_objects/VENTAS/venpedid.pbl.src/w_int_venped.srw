$PBExportHeader$w_int_venped.srw
forward
global type w_int_venped from wc_mantenimientos_tab
end type
type dw_res from u_datawindow within pagina_1
end type
type uo_cliente from u_em_campo_2 within pagina_4
end type
type st_2 from statictext within pagina_4
end type
type st_4 from statictext within pagina_4
end type
type em_anyo from u_em_campo within w_int_venped
end type
type pb_calculadora from u_calculadora within w_int_venped
end type
type cb_lineas from u_boton within w_int_venped
end type
type dw_proceso from datawindow within w_int_venped
end type
type pb_imprimir from upb_imprimir within w_int_venped
end type
type cb_1 from u_boton within w_int_venped
end type
type dw_report from datawindow within w_int_venped
end type
type gb_1 from groupbox within w_int_venped
end type
type st_3 from statictext within w_int_venped
end type
type dw_nombre_cliente from datawindow within w_int_venped
end type
type st_orden from statictext within w_int_venped
end type
type pb_duplicar from picturebutton within w_int_venped
end type
end forward

global type w_int_venped from wc_mantenimientos_tab
integer width = 3195
integer height = 2264
em_anyo em_anyo
pb_calculadora pb_calculadora
cb_lineas cb_lineas
dw_proceso dw_proceso
pb_imprimir pb_imprimir
cb_1 cb_1
dw_report dw_report
gb_1 gb_1
st_3 st_3
dw_nombre_cliente dw_nombre_cliente
st_orden st_orden
pb_duplicar pb_duplicar
end type
global w_int_venped w_int_venped

type variables
str_venped  venped
String antecliente,acceso
Boolean calculadora_pulsada
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_imprime_nombre_cliente (datawindow data, string cliente, integer anyo, decimal pedido)
public subroutine f_riesgos (string cliente)
end prototypes

public subroutine f_control ();str_venliped linped
str_venped   ped 
DataStore d
Dec periodo,pedido
String sel

Integer  reg,reg1 
periodo   =  Integer(em_anyo.text)
pedido    =  Dec(sle_valor.text)
sel = " Select * from venliped " +&
		" Where  empresa = '"+codigo_empresa+"'" +&
		" And    anyo    = "+String(periodo,"#######") +&
		" And    pedido  = "+String(pedido,"#######")

//d = f_cargar_cursor2(sel)
f_Cargar_cursor_nuevo(sel, d)


reg1 = d.RowCount()
linped.empresa   = codigo_empresa
linped.anyo      = periodo
linped.pedido  = pedido
For reg = 1 To reg1 
 linped.linea              = d.GetItemNumber(reg,"linea")
 f_actualizar_linea_venpedido(codigo_empresa,periodo,pedido,linped.linea)
Next
f_actualizar_venpedido(codigo_empresa,periodo,pedido)
COMMIT;

destroy d
end subroutine

public subroutine f_imprime_nombre_cliente (datawindow data, string cliente, integer anyo, decimal pedido);String    nombre_cliente,nombrex,nombre1,nombre2,var_envio,car
long      donde,longi,blanco,posiciones[100],i,posi

data.setredraw(false)

var_envio = f_pedido_direnvio_sn(codigo_empresa,anyo,pedido)
if var_envio = "" or isnull(var_envio) then
	nombre_cliente  = trim(f_razon_genter(codigo_empresa,"C",cliente))
else
	nombre_cliente = trim(f_nombre_venenvio(codigo_empresa,cliente,var_envio))
end if

longi  = len(trim(nombre_cliente))
nombre1 = ""
nombre2 = ""
if longi > 21 then
	for i = 1 to 100
		posiciones[i] = -1
	next
	for i = 1 to longi
		car = mid(nombre_cliente,i,1)
		if car = " " then
			posiciones[i] = i
		end if
	next
	for i = 1 to 100
		if posiciones[i] <> -1 then
			nombrex = mid(nombre_cliente,1,posiciones[i]-1)
			if len(nombrex) <= 16 then
				nombre1 = nombrex
				posi    = posiciones[i]
			end if
		end if
	next
	nombre2 = mid(nombre_cliente,posi+1,longi)
else
	nombre1 = trim(nombre_cliente)
end if
	
dw_nombre_cliente.Retrieve(codigo_empresa,cliente)

donde = data.insertrow(0)
data.object.empresa[donde]   = codigo_empresa
data.object.nombre[donde]    = nombre1
data.object.nombre2[donde]   = nombre2
data.sort()
data.groupcalc()
data.setredraw(true)
f_imprimir_datawindow_v2(data)
end subroutine

public subroutine f_riesgos (string cliente);long donde
int altura_dw_res = 60, i = 1
dec alb,fac,cobro,nego,devo,gasto,concedido
dec pedidos_pdtes, stock_deposito
tipo_array vencido

concedido = f_riesgo_concedio(codigo_empresa,cliente)
if isnull(concedido) then concedido = 0
donde=apartados.pagina_1.dw_res.insertrow(0)
apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
apartados.pagina_1.dw_res.setitem(donde,"concepto","Riesgo Concedido")
apartados.pagina_1.dw_res.setitem(donde,"cantidad",concedido)

// David 18-01-05: Controlamos los pedidos pendientes.
pedidos_pdtes = f_pedidos_pdtes(codigo_empresa,cliente)
if pedidos_pdtes <> 0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Pedidos Pendientes")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",pedidos_pdtes)
end if

stock_deposito = f_importe_stock_deposito_cliente (codigo_empresa,cliente)
if stock_deposito <> 0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Importe Stock Depósito")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",stock_deposito )
	i ++
end if

// fin david

alb=f_alb_pdtes_facturar(codigo_empresa,cliente)
if alb<>0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Albaranes Pendientes de Facturar")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",alb)
	i++
end if

fac=f_fac_pdtes_actualizar(codigo_empresa,cliente)
if fac<>0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Facturas Pendientes de Actualizar")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",fac)
	i++
end if

cobro=f_fac_pdtes_cobro(codigo_empresa,cliente)
if cobro<>0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Recibos Pendientes de Cobro")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",cobro)
	i++
end if

nego=f_negociado_pdtes_cobro(codigo_empresa,cliente)
if nego<>0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Negociado Pendiente de Cobro")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",nego)
	i++
end if

vencido=f_fac_vencidas(codigo_empresa,cliente)

if dec(vencido.valor[1])<>0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Recibos Vencidos entre 1 y 30 días")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",dec(vencido.valor[1]))
	i++
end if
if dec(vencido.valor[2])<>0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Recibos Vencidos entre 30 y 60 días")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",dec(vencido.valor[2]))
	i++
end if
if dec(vencido.valor[3])<>0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Recibos Vencidos entre 60 y 90 días")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",dec(vencido.valor[3]))
	i++
end if
if dec(vencido.valor[4])<>0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Recibos Vencidos mas de 90 días")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",dec(vencido.valor[4]))
	i++
end if

devo=f_fac_devuelto(codigo_empresa,cliente)
if devo<>0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Devoluciones")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",devo)
	i++
end if

gasto=f_fac_gasto(codigo_empresa,cliente)
if gasto<>0 then
	donde=apartados.pagina_1.dw_res.insertrow(0)
	apartados.pagina_1.dw_res.setitem(donde,"empresa",codigo_empresa)
	apartados.pagina_1.dw_res.setitem(donde,"concepto","Gastos")
	apartados.pagina_1.dw_res.setitem(donde,"cantidad",gasto)
	i++
end if

if (i * altura_dw_res) + 550	> 1300 then
	apartados.pagina_1.dw_res.Height = 1300
else
	apartados.pagina_1.dw_res.Height = (i * altura_dw_res) + 550
end if
//apartados.pagina_1.dw_res.Object.DataWindow.Detail.Height = (i * altura_dw_res) + 500	

end subroutine

event ue_valores;call super::ue_valores;pag1 = TRUE	
pag2 = TRUE
pag3 = TRUE
pag4 = TRUE


prin_pag1  =  TRUE
pag_act4   =  FALSE
pag_act5   =  FALSE

end event

on w_int_venped.create
int iCurrent
call super::create
this.em_anyo=create em_anyo
this.pb_calculadora=create pb_calculadora
this.cb_lineas=create cb_lineas
this.dw_proceso=create dw_proceso
this.pb_imprimir=create pb_imprimir
this.cb_1=create cb_1
this.dw_report=create dw_report
this.gb_1=create gb_1
this.st_3=create st_3
this.dw_nombre_cliente=create dw_nombre_cliente
this.st_orden=create st_orden
this.pb_duplicar=create pb_duplicar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_anyo
this.Control[iCurrent+2]=this.pb_calculadora
this.Control[iCurrent+3]=this.cb_lineas
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_report
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.dw_nombre_cliente
this.Control[iCurrent+11]=this.st_orden
this.Control[iCurrent+12]=this.pb_duplicar
end on

on w_int_venped.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_anyo)
destroy(this.pb_calculadora)
destroy(this.cb_lineas)
destroy(this.dw_proceso)
destroy(this.pb_imprimir)
destroy(this.cb_1)
destroy(this.dw_report)
destroy(this.gb_1)
destroy(this.st_3)
destroy(this.dw_nombre_cliente)
destroy(this.st_orden)
destroy(this.pb_duplicar)
end on

event ue_recuperar;Long en_orden_carga = 0
Dec v_anyo, v_pedido
Int devuelto
//-------------------------------------------------
// Valores Para Funcion de bloqueo-----------------
//-------------------------------------------------

titulo        =  This.title

longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_anyo.text))
criterio[2]   =  Trim(string(dec(em_anyo.text)))+space(20-longitud)
longitud      =  len(trim(string(dec(sle_valor.text))))
criterio[3]   =  trim(string(dec(sle_valor.text)))+space(20-longitud)
seleccion[1]  =  criterio[1]+criterio[2]+criterio[3]
tabla[1]      = "venped"

IF dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text)) = 0 Then
	dw_pag1.SetTabOrder("cliente",1)
	dw_pag1.SetTabOrder("fpedido",2)
	st_orden.visible = false
ELSE
	 if f_pedido_impreso_sn(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))="S" then
		 if acceso<>"1" then
			 dw_pag1.SetTabOrder("cliente",0)
			 dw_pag1.SetTabOrder("fpedido",1)
		 End if
     else
		 dw_pag1.SetTabOrder("cliente",1)
	    dw_pag1.SetTabOrder("fpedido",2)
    End if
	 
	v_anyo = Dec(em_anyo.text)
	v_pedido = Dec(sle_valor.text)
	
	if ftc_pedido_en_orden_carga(v_anyo, v_pedido) then
		st_orden.visible = true
		dw_pag1.SetTabOrder("cliente",0)
		dw_pag2.SetTabOrder("envio",0)
	else
		dw_pag1.SetTabOrder("cliente",1)
		dw_pag2.SetTabOrder("envio",280)		
		st_orden.visible = false
	end if
END IF


devuelto = dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag2.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag3.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))

if devuelto < 1 and not calculadora_pulsada then
//	MessageBox("Error","El pedido no existe. Debe introducir un pedido usando la calculadora.")
//	pb_calculadora.triggerevent("clicked")
//	return
	IF insercion = "S" Then
		sle_valor.text = ""
		sle_valor.TriggerEvent("modificado")
		cb_borrar.enabled  =FALSE
		wc_reset()
	END IF
	insercion= "N"
	this.TriggerEvent("ue_desbloquear")
	cb_insertar.enabled = FALSE
	this.TriggerEvent("ue_activa_claves")
	
	f_activar_campo(sle_valor)
	return
else
	calculadora_pulsada = false
end if

CALL Super::ue_recuperar


end event

event ue_inserta_fila;call super::ue_inserta_fila;
IF Trim(f_valor_columna(dw_pag1,1,"empresa")) = "" Then
 dw_pag1.SetItem(1,"fpedido",DateTime(Today()))
 dw_pag1.SetItem(1,"es_proforma", 'N')
 dw_pag1.SetItem(1,"es_courier", 'N')
 dw_pag1.SetItem(1,"usuario_pedido",nombre_usuario)
 dw_pag1.SetItem(1,"usuario",nombre_usuario)
 dw_pag2.SetItem(1,"calculo_dto","N")
 dw_pag2.SetItem(1,"calculo_dtoesp","N")
END IF

dw_pag1.SetItem(1,"empresa",codigo_empresa)
dw_pag1.SetItem(1,"pedido",Dec(sle_valor.text))
dw_pag1.SetItem(1,"anyo",Dec(em_anyo.text))
dw_pag2.SetItem(1,"empresa",codigo_empresa)







end event

event open;call super::open;titulo= "Introducción de Pedidos"
This.title = titulo

calculadora_pulsada = false

dw_proceso.SetTransObject(SQLCA)
dw_nombre_cliente.SetTransObject(SQLCA)
dw_pag1.SetTransObject(SQLCA)
dw_pag2.SetTransObject(SQLCA)
dw_pag4.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_report.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))

// Se controla el nivel de acceso del usuario
   acceso = f_control_acceso(nombre_usuario)
 
f_mascara_columna(dw_pag1,"peso","###,###")
f_mascara_columna(dw_pag1,"peso_neto","###,###")
f_mascara_columna(dw_pag2,"dtoesp1","###.00")
f_mascara_columna(dw_pag2,"dtoesp2","###.00")
f_mascara_columna(dw_pag2,"dtoesp3","###.00")
f_mascara_columna(dw_pag2,"dtoesp4","###.00")
f_mascara_columna(dw_pag2,"dtopp","###.00")

f_mascara_columna(dw_pag2,"comision1","###.00")
f_mascara_columna(dw_pag2,"comision11","###.00")
f_mascara_columna(dw_pag2,"comision2","###.00")
f_mascara_columna(dw_pag2,"comision22","###.00")
f_mascara_columna(dw_pag2,"comision31","###.00")
f_mascara_columna(dw_pag2,"comision32","###.00")

 // Si recibo el codigo lo visualizo
   
IF istr_parametros.i_nargumentos>1 THEN
	em_anyo.text=istr_parametros.s_argumentos[2]
	sle_valor.text=istr_parametros.s_argumentos[3]
	IF len(sle_valor.text) <> 0  and len(em_anyo.text)<> 0 Then
	 This.TriggerEvent("ue_recuperar")
	 f_activar_campo(sle_valor)
	END IF
END IF
	
	
end event

event ue_pase_valores;call super::ue_pase_valores;dw_pag1.SetItem(1,"observaciones",dw_pag2.GetItemString(1,"observaciones"))
dw_pag1.SetItem(1,"observaciones2",dw_pag2.GetItemString(1,"observaciones2"))
dw_pag1.SetItem(1,"agente1",dw_pag2.GetItemString(1,"agente1"))
dw_pag1.SetItem(1,"agente2",dw_pag2.GetItemString(1,"agente2"))
dw_pag1.SetItem(1,"agente3",dw_pag2.GetItemString(1,"agente3"))
dw_pag1.SetItem(1,"comision_fija1",dw_pag2.GetItemstring(1,"comision_fija1"))
dw_pag1.SetItem(1,"comision_fija2",dw_pag2.GetItemstring(1,"comision_fija2"))
dw_pag1.SetItem(1,"comision_fija3",dw_pag2.GetItemstring(1,"comision_fija3"))
dw_pag1.SetItem(1,"comision1",dw_pag2.GetItemNumber(1,"comision1"))
dw_pag1.SetItem(1,"comision2",dw_pag2.GetItemNumber(1,"comision2"))
dw_pag1.SetItem(1,"comision31",dw_pag2.GetItemNumber(1,"comision31"))
dw_pag1.SetItem(1,"comision11",dw_pag2.GetItemNumber(1,"comision11"))
dw_pag1.SetItem(1,"comision22",dw_pag2.GetItemNumber(1,"comision22"))
dw_pag1.SetItem(1,"comision32",dw_pag2.GetItemNumber(1,"comision32"))
dw_pag1.SetItem(1,"dtopp",dw_pag2.GetItemNumber(1,"dtopp"))
dw_pag1.SetItem(1,"dtoesp1",dw_pag2.GetItemNumber(1,"dtoesp1"))
dw_pag1.SetItem(1,"dtoesp2",dw_pag2.GetItemNumber(1,"dtoesp2"))
dw_pag1.SetItem(1,"dtoesp3",dw_pag2.GetItemNumber(1,"dtoesp3"))
dw_pag1.SetItem(1,"dtoesp4",dw_pag2.GetItemNumber(1,"dtoesp4"))
dw_pag1.SetItem(1,"tipodto1",dw_pag2.GetItemString(1,"tipodto1"))
dw_pag1.SetItem(1,"tipodto2",dw_pag2.GetItemString(1,"tipodto2"))
dw_pag1.SetItem(1,"tipodto3",dw_pag2.GetItemString(1,"tipodto3"))
dw_pag1.SetItem(1,"tipodto4",dw_pag2.GetItemString(1,"tipodto4"))
dw_pag1.SetItem(1,"calculo_dto",dw_pag2.GetItemString(1,"calculo_dto"))
dw_pag1.SetItem(1,"calculo_dtoesp",dw_pag2.GetItemString(1,"calculo_dtoesp"))
dw_pag1.SetItem(1,"explicaciondto1",dw_pag2.GetItemString(1,"explicaciondto1"))
dw_pag1.SetItem(1,"explicaciondto2",dw_pag2.GetItemString(1,"explicaciondto2"))
dw_pag1.SetItem(1,"explicaciondto3",dw_pag2.GetItemString(1,"explicaciondto3"))
dw_pag1.SetItem(1,"explicaciondto4",dw_pag2.GetItemString(1,"explicaciondto4"))


dw_pag1.SetItem(1,"envio",dw_pag2.GetItemString(1,"envio"))
dw_pag1.SetItem(1,"correspondencia",dw_pag2.GetItemString(1,"correspondencia"))
dw_pag1.SetItem(1,"domiciliacion",dw_pag2.GetItemString(1,"domiciliacion"))
dw_pag1.SetItem(1,"transportista",dw_pag2.GetItemString(1,"transportista"))
dw_pag1.setitem(1,"tipo_portes",dw_pag2.GetItemString(1,"tipo_portes"))

dw_pag1.SetItem(1,"textcomercial1",dw_pag3.GetItemString(1,"textcomercial1"))
dw_pag1.SetItem(1,"textcomercial2",dw_pag3.GetItemString(1,"textcomercial2"))
dw_pag1.SetItem(1,"textaduanaesp1",dw_pag3.GetItemString(1,"textaduanaesp1"))
dw_pag1.SetItem(1,"textaduanaesp2",dw_pag3.GetItemString(1,"textaduanaesp2"))
dw_pag1.SetItem(1,"textaduanaext1",dw_pag3.GetItemString(1,"textaduanaext1"))
dw_pag1.SetItem(1,"textaduanaext2",dw_pag3.GetItemString(1,"textaduanaext2"))

dw_pag1.SetItem(1,"agrupa",dw_pag2.GetItemString(1,"agrupa"))
dw_pag1.SetItem(1,"agrupa_exp",dw_pag2.GetItemString(1,"agrupa_exp"))
dw_pag1.SetItem(1,"periodo_fac",dw_pag2.GetItemString(1,"periodo_fac"))
end event

event ue_activa_claves;call super::ue_activa_claves;apartados.pagina_4.visible = TRUE
cb_lineas.enabled      = TRUE
st_3.visible           = True
pb_calculadora.visible = TRUE
pb_imprimir.visible	  = TRUE

end event

event ue_desactiva_claves;call super::ue_desactiva_claves;apartados.pagina_4.visible = FALSE
cb_lineas.enabled = FALSE
pb_calculadora.visible = FALSE
pb_imprimir.visible = FALSE
st_3.visible        = False
end event

event ue_f6;call super::ue_f6;cb_lineas.TriggerEvent(Clicked!)
end event

event ue_borra_fila;Integer anyo
Dec{0}  pedido
long    lineas,ordenes
boolean bien = true

anyo = Dec(em_anyo.text)
pedido = Dec(sle_valor.text)

select count(*)
into   :lineas
from   venliped
Where  empresa = :codigo_empresa
And    anyo    = :anyo
And    pedido  = :pedido;

if isnull(lineas) then lineas = 0
if lineas > 0 then
	Delete from  venliped
	Where  empresa = :codigo_empresa
	And    anyo    = :anyo
	And    pedido  = :pedido;
	
	if sqlca.sqlcode <> 0 then
		rollback;
		bien = false
		messagebox("Atención","Se ha producido un error al borrar las lineas del pedido.")
	end if
end if

select count(*)
into   :ordenes
From   almlincargas  
WHERE  almlincargas.empresa    = :codigo_empresa
AND    almlincargas.anyo_ped   = :anyo
AND    almlincargas.pedido     = :pedido;

if isnull(lineas) then lineas = 0
if lineas > 0 then
	Delete  From    almlincargas  
	WHERE   almlincargas.empresa    = :codigo_empresa
	AND     almlincargas.anyo_ped   = :anyo
	AND     almlincargas.pedido     = :pedido;
	
	if sqlca.sqlcode <> 0 then
		rollback;
		bien = false
		messagebox("Atención","Se ha producido un error al borrar las lineas de ordenes de carga.")
	end if
end if
if bien then
	Call Super::ue_borra_fila
end if

end event

event ue_actualiza_dw;call super::ue_actualiza_dw;dec cantidad,cantidad_facturar,linea,calculo_cantidad_facturar
dec anyo,pedido,orden
string articulo,facturar_metros_reales,caja,unidad
string sel,ls_es_proforma
long indice,total
datastore lineas
Str_venliped v
boolean lb_correcto = true

v.empresa = codigo_empresa
v.anyo    =  Dec(em_anyo.text)
v.pedido  =  Dec(sle_valor.text)

  SELECT venped.cliente,   
         venped.agente1,   
         venped.agente2,   
         venped.comision1,   
         venped.comision2,   
         venped.comision11,   
         venped.comision22,   
         venped.divisa,   
         venped.serie,   
         venped.zona,   
         venped.agente3,   
         venped.comision32,   
         venped.comision31,   
         venped.transportista,
			venped.envio,
			venped.numpedcli,
			venped.almacen_de_carga,
			venped.facturar_metros_reales,
			venped.es_proforma
    INTO :v.cliente,   
         :v.agente1,   
         :v.agente2,   
         :v.comision11,   
         :v.comision21,   
         :v.comision12,   
         :v.comision22,   
         :v.divisa,   
         :v.serie,   
         :v.zona,   
         :v.agente3,   
         :v.comision32,   
         :v.comision31,   
         :v.transportista  ,
			:v.envio,
			:v.numpedcli,
			:v.almacen_de_carga,
			:facturar_metros_reales,
			:ls_es_proforma
   FROM  venped  
   WHERE venped.empresa = :v.empresa
	AND   venped.anyo = :v.anyo
	AND   venped.pedido = :v.pedido ;


v.pais      = f_pais_genter(v.empresa,"C",v.cliente)
v.provincia = f_provincia_genter(v.empresa,"C",v.cliente)

if ls_es_proforma = 'S' then
	
	Update  venliped 
	Set venliped.cliente        = :v.cliente,
		 venliped.agente1        = :v.agente1,   
		 venliped.agente2        = :v.agente2,   
		 venliped.comision11     = :v.comision11,   
		 venliped.comision21     = :v.comision21,   
		 venliped.comision12     = :v.comision12,   
		 venliped.comision22     = :v.comision22,   
		 venliped.divisa         = :v.divisa,   
		 venliped.serie          = :v.serie,   
		 venliped.zona           = :v.zona,   
		 venliped.agente3        = :v.agente3,   
		 venliped.comision32     = :v.comision32,   
		 venliped.comision31     = :v.comision31,   
		 venliped.transportista  = :v.transportista,
		 venliped.pais           = :v.pais,
		 venliped.provincia      = :v.provincia,
		 venliped.envio			 = :v.envio,
		 venliped.numpedcli		 = :v.numpedcli,
		 venliped.almacen_de_carga = :v.almacen_de_carga,
		 venliped.situacion      = 'F' 
	Where   venliped.empresa  = :v.empresa
	And     venliped.anyo     = :v.anyo
	And     venliped.pedido   = :v.pedido Using sqlca;
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
	end if	
else
	Update  venliped 
	Set venliped.cliente        = :v.cliente,
		 venliped.agente1        = :v.agente1,   
		 venliped.agente2        = :v.agente2,   
		 venliped.comision11     = :v.comision11,   
		 venliped.comision21     = :v.comision21,   
		 venliped.comision12     = :v.comision12,   
		 venliped.comision22     = :v.comision22,   
		 venliped.divisa         = :v.divisa,   
		 venliped.serie          = :v.serie,   
		 venliped.zona           = :v.zona,   
		 venliped.agente3        = :v.agente3,   
		 venliped.comision32     = :v.comision32,   
		 venliped.comision31     = :v.comision31,   
		 venliped.transportista  = :v.transportista,
		 venliped.pais           = :v.pais,
		 venliped.provincia      = :v.provincia,
		 venliped.envio			 = :v.envio,
		 venliped.numpedcli		 = :v.numpedcli,
		 venliped.almacen_de_carga = :v.almacen_de_carga
	Where   venliped.empresa  = :v.empresa
	And     venliped.anyo     = :v.anyo
	And     venliped.pedido   = :v.pedido Using sqlca;	
	
	if sqlca.sqlcode <> 0 then
		lb_correcto = false
	else
		string ls_sel,ls_articulo,ls_calidad,ls_tonochar,ls_tipo_pallet,ls_caja, ls_tipolinea
		int    li_calibre
		dec    ld_cantidad,ld_disponible
		long   ll_indice,ll_total
		datastore ds_lineas
		
		ls_sel = "select venliped.articulo, "+&
					"       venliped.calidad, "+&
					"       venliped.tonochar, "+&
					"       venliped.calibre, "+&
					"       venliped.tipo_pallet, "+&
					"       venliped.caja, "+&
					"       sum(venliped.cantidad) as cantidad, "+&
					"		  venliped.tipolinea "+&
					"from   venliped "+&
					"where  venliped.empresa = '"+v.empresa+"' "+&
					"and    venliped.anyo    = "+string(v.anyo,"###0")+" "+&
					"and    venliped.pedido  = "+string(v.pedido,"#####0")+" "+&
					"and    venliped.situacion = 'F' "+&
					"group by venliped.articulo, "+&
					"         venliped.calidad, "+&
					"         venliped.tonochar, "+&
					"         venliped.calibre, "+&
					"         venliped.tipo_pallet, "+&
					"         venliped.caja, " +&
					"			 venliped.tipolinea "
					
		ll_total = f_cargar_cursor_transaccion(sqlca,ds_lineas,ls_sel)
		
		for ll_indice = 1 to ll_total
			ls_articulo    = ds_lineas.object.articulo[ll_indice]
			ls_calidad     = ds_lineas.object.calidad[ll_indice]
			ls_tonochar    = ds_lineas.object.tonochar[ll_indice]
			li_calibre     = ds_lineas.object.calibre[ll_indice]
			ls_tipo_pallet = ds_lineas.object.tipo_pallet[ll_indice]
			ls_caja        = ds_lineas.object.caja[ll_indice]
			ld_cantidad    = ds_lineas.object.cantidad[ll_indice]
			ld_disponible  = f_disponible_art_cal_to_ca_tp_c(codigo_empresa,ls_articulo,ls_calidad,ls_tonochar,li_calibre,ls_tipo_pallet,ls_caja)	
			ls_tipolinea 	= ds_lineas.object.tipolinea[ll_indice]
			
			
			/* MARCOS 20/01/2021 EXCLUÍMOS EL TIPO DE LÍNEA 4 (PROMOCIÓN) EN LA RESERVA AUTOMÁTICA */
			//if ld_disponible >= ld_cantidad then
			if ld_disponible >= ld_cantidad and ls_tipolinea <> '4' then
				//Reservamos
				update venliped
				set    venliped.situacion = 'C'
				where  venliped.empresa  = :v.empresa
				and    venliped.anyo     = :v.anyo
				and    venliped.pedido   = :v.pedido
				and    venliped.articulo = :ls_articulo
				and    venliped.calidad = :ls_calidad
				and    venliped.tonochar = :ls_tonochar
				and    venliped.calibre = :li_calibre
				and    venliped.tipo_pallet = :ls_tipo_pallet
				and    venliped.caja = :ls_caja
				and    venliped.situacion <> 'P';
			else
				//No reservamos
				update venliped
				set    venliped.situacion = 'F'
				where  venliped.empresa  = :v.empresa
				and    venliped.anyo     = :v.anyo
				and    venliped.pedido   = :v.pedido
				and    venliped.articulo = :ls_articulo
				and    venliped.calidad = :ls_calidad
				and    venliped.tonochar = :ls_tonochar
				and    venliped.calibre = :li_calibre
				and    venliped.tipo_pallet = :ls_tipo_pallet
				and    venliped.caja = :ls_caja
				and    venliped.situacion <> 'P';				
			end if
			
			if sqlca.sqlcode <> 0 then
				lb_correcto = false
			end if
			
		next
			
		destroy ds_lineas
	end if
end if

if not(lb_correcto) then
	rollback;
	messagebox("Atención","Se ha producido un error actualizando las lineas del pedido")
else
	COMMIT;
end if


update almlincargas
set almacen_de_carga = :v.almacen_de_carga,
    ubicacion        = ''
Where   almlincargas.empresa  = :v.empresa
And     almlincargas.anyo_ped = :v.anyo
And     almlincargas.pedido   = :v.pedido 
And     almlincargas.almacen_de_carga <> :v.almacen_de_carga
Using sqlca;

if sqlca.sqlcode <> 0 then
	rollback;
else
	commit;
end if
//Control para la facturación en metros reales o no

//Control en lineas de pedido
sel = "select linea,cantidad,cantidad_facturar,articulo,caja "+&
		"from venliped "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and anyo = "+string(dec(em_anyo.text))+" "+&
		"and pedido = "+string(dec(sle_valor.text))

f_cargar_cursor_nuevo(sel, lineas)
total = lineas.rowcount()
for indice = 1 to total
	linea             = lineas.object.linea[indice]
	cantidad          = lineas.object.cantidad[indice]
	cantidad_facturar = lineas.object.cantidad_facturar[indice]
	articulo          = lineas.object.articulo[indice]
	caja              = lineas.object.caja[indice]
	unidad            = f_unidad_articulo(codigo_empresa,articulo)
	anyo              = dec(em_anyo.text)
	pedido            = dec(sle_valor.text)
	if unidad = "1" then
		if facturar_metros_reales = "S" then
			calculo_cantidad_facturar = f_cantidad_facturar_articulo(codigo_empresa,articulo,caja,cantidad)
			if calculo_cantidad_facturar <> cantidad_facturar then
				update venliped
				set cantidad_facturar = :calculo_cantidad_facturar
				where empresa = :codigo_empresa
				and   anyo    = :anyo
				and   pedido  = :pedido
				and   linea   = :linea;
				if sqlca.sqlcode <> 0 then
					rollback;
					messagebox("Atención","Se ha producido un error al actualizar los metros reales de una linea del pedido.")
				else
					commit;
				end if
			end if
		else			
			if cantidad_facturar <> cantidad then
				update venliped
				set cantidad_facturar = cantidad
				where empresa = :codigo_empresa
				and   anyo    = :anyo
				and   pedido  = :pedido
				and   linea   = :linea;
				if sqlca.sqlcode <> 0 then
					rollback;
					messagebox("Atención","Se ha producido un error al actualizar los metros reales de una linea del pedido.")
				else
					commit;
				end if
			end if			
		end if
	end if
next
//Control en lineas de ordenes de carga
sel = "select anyo,orden,linea,cantidad,cantidad_facturar,articulo,caja "+&
		"from almlincargas "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and anyo_ped = "+string(dec(em_anyo.text))+" "+&
		"and pedido = "+string(dec(sle_valor.text))

f_cargar_cursor_nuevo(sel, lineas)
total = lineas.rowcount()
for indice = 1 to total
	anyo              = lineas.object.anyo[indice]
	orden             = lineas.object.orden[indice]
	linea             = lineas.object.linea[indice]
	cantidad          = lineas.object.cantidad[indice]
	cantidad_facturar = lineas.object.cantidad_facturar[indice]
	articulo          = lineas.object.articulo[indice]
	caja              = lineas.object.caja[indice]
	unidad            = f_unidad_articulo(codigo_empresa,articulo)
	if unidad = "1" then
		if facturar_metros_reales = "S" then
			calculo_cantidad_facturar = f_cantidad_facturar_articulo(codigo_empresa,articulo,caja,cantidad)
			if calculo_cantidad_facturar <> cantidad_facturar then
				update almlincargas
				set cantidad_facturar = :calculo_cantidad_facturar					 
				where empresa = :codigo_empresa
				and   anyo    = :anyo
				and   orden   = :orden
				and   linea   = :linea;
				if sqlca.sqlcode <> 0 then
					rollback;
					messagebox("Atención","Se ha producido un error al actualizar los metros reales de una linea orden de carga.")
				else
					commit;
				end if
			end if
		else			
			if cantidad_facturar <> cantidad then
				update almlincargas
				set cantidad_facturar = cantidad
				where empresa = :codigo_empresa
				and   anyo    = :anyo
				and   orden   = :orden
				and   linea   = :linea;
				if sqlca.sqlcode <> 0 then
					rollback;
					messagebox("Atención","Se ha producido un error al actualizar los metros reales de una linea de orden de carga.")
				else
					commit;
				end if
			end if			
		end if
	end if
next
//Fin control para la facturación en metros reales o no
destroy lineas

f_control()
COMMIT;

end event

event ue_f2;pb_calculadora.TriggerEvent(Clicked!)
end event

event activate;call super::activate;w_int_venped = ventanas_activas[id_ventana_activa].ventana
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_int_venped
integer x = 2094
integer y = 176
integer width = 306
integer height = 76
integer taborder = 0
string text = "&Salir"
end type

event cb_salir::clicked;call super::clicked;//IF cb_insertar.enabled=TRUE THEN
//	// saldo de proceso de altas
//	IF insercion = "S" Then
//		sle_valor.text = ""
//		sle_valor.TriggerEvent("modificado")
//		cb_borrar.enabled  =FALSE
//		wc_reset()
//	END IF
//	Close (Parent)
//ELSE
//	Close (Parent)
//END IF
end event

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_int_venped
integer x = 1787
integer y = 176
integer width = 306
integer height = 76
integer taborder = 0
string text = "&Borrar"
end type

event cb_borrar::clicked;Integer numero,v_anyo
Dec{0}  v_pedido
Long planificado

v_anyo   = Dec(em_anyo.text)
v_pedido = Dec(sle_valor.text)



//VIEJO SISTEMA DE PREPARACIÓN
Select Count(*) Into :numero From venliped
Where  venliped.empresa = :codigo_empresa
And    venliped.anyo    = :v_anyo
And    venliped.pedido  = :v_pedido
And    venliped.situacion = "P";

IF IsNull(numero) Then numero = 0
IF numero <>0 Then
		f_mensaje("Este pedido no se puede borrar","Existen lines preparadas")
		f_activar_campo(sle_valor)
		Return
END IF

//NUEVO SISTEMA DE PREPARACIÓN
if ftc_pedido_en_orden_carga(v_anyo,v_pedido) then
	MessageBox("Pedido en Orden de Carga", "No se puede borrar un pedido con material preparado. Contacte con el almacén.",information!,Ok!) 
	return
end if

//PLANIFICADO
SELECT COUNT(*) INTO :planificado FROM planificacion WHERE empresa = :codigo_empresa AND anyo = :v_anyo AND pedido = :v_pedido;
if planificado > 0 then
	MessageBox("Pedido Planificado", "No se puede borrar un pedido ya planificado. Contacte con planificación.",information!,Ok!) 
	Return 
end if

 // control de borrar
 Integer veces
 veces = apartados.pagina_1.dw_pagina1.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'veces')	
 if veces>0 then
	 if acceso<>"1" then
		 f_mensaje("! A t e n c i ó n ¡","Este pedido esta impreso, usted no tiene acceso para borrarlo.")
		 f_activar_campo(sle_valor)
		 Return
	End if
 End if

 Call Super::Clicked
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_int_venped
integer x = 1481
integer y = 176
integer width = 306
integer height = 76
integer taborder = 0
end type

event cb_insertar::clicked;IF  cb_insertar.enabled = TRUE Then	
	String var_codpago,var_bancocobro,control_banco,campo,var_codcli,d_cod_pago,d_agente1,c_cod_pago,c_agente1,var_referencia
	String var_tarifa,var_divisa,var_tipiva,var_deposito,in_incidencia,var_agente1
	String var_almacen_deposito,var_direnvio,var_envio,var_obser,c_refer,c_domiciliacion,var_domiciliacion
	Dec var_dtoesp1,var_dtoesp2,var_dtoesp3,var_dtoesp4,var_comi1,var_comi11
	Dec c_dtoesp1,c_dtoesp2,c_dtoesp3,c_dtoesp4,c_comi1,c_comi11
	datawindow dato
	Integer numero, bloqueados_pedidos
	Dec var_dtopp,c_dtopp
	string var_almacen_de_carga, cuenta_cliente
	
	apartados.pagina_1.dw_pagina1.AcceptText()
	apartados.pagina_2.dw_pagina2.AcceptText()
	
	var_codpago    = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'codpago')	
	var_referencia = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'numpedcli')	
	var_bancocobro = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'banco_de_cobro')	
	var_codcli     = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'cliente')	
	var_tarifa     = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'tarifa')	
	var_divisa     = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'divisa')	
	var_codpago    = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'codpago')	
	var_agente1    = apartados.pagina_2.dw_pagina2.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'agente1')	
	var_dtopp      = apartados.pagina_2.dw_pagina2.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'dtopp')	
	var_dtoesp1    = apartados.pagina_2.dw_pagina2.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'dtoesp1')
	var_dtoesp2    = apartados.pagina_2.dw_pagina2.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'dtoesp2')	
	var_dtoesp3    = apartados.pagina_2.dw_pagina2.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'dtoesp3')	
	var_dtoesp4    = apartados.pagina_2.dw_pagina2.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'dtoesp4')	
	var_comi1      = apartados.pagina_2.dw_pagina2.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'comision1')	
	var_comi11     = apartados.pagina_2.dw_pagina2.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'comision11')	
	var_tipiva     = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'tipoiva')	
	var_deposito   = f_deposito_venclientes(codigo_empresa,var_codcli)
	var_almacen_deposito = f_depalmacen_cliente(codigo_empresa,var_codcli)
	var_direnvio   = f_sn_direnvio_venclientes(codigo_empresa,var_codcli)
	var_envio      = apartados.pagina_2.dw_pagina2.GetItemString(apartados.pagina_2.dw_pagina2.GetRow(),'envio')	
	var_obser      = apartados.pagina_2.dw_pagina2.GetItemString(apartados.pagina_2.dw_pagina2.GetRow(),'observaciones')	
   var_domiciliacion	= apartados.pagina_2.dw_pagina2.GetItemString(apartados.pagina_2.dw_pagina2.GetRow(),'domiciliacion')	
	var_almacen_de_carga = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'almacen_de_carga')	
	if isNull(var_codpago)    then var_codpago    = ""
	if isNull(var_codcli)     then var_codcli     = ""
	if isNull(var_tarifa)     then var_tarifa     = ""
	if isNull(var_divisa)     then var_divisa     = ""
	if isNull(var_bancocobro) then var_bancocobro = ""
	if isNull(var_tipiva)     then var_tipiva     = ""
	if isNull(var_envio)      then var_envio      = ""
	if isNull(var_obser)      then var_obser      = ""
	if isNull(var_domiciliacion)      then var_domiciliacion = ""
	if isnull(var_dtoesp1) then var_dtoesp1 = 0
	if isnull(var_dtoesp2) then var_dtoesp2 = 0
	if isnull(var_dtoesp3) then var_dtoesp3 = 0
	if isnull(var_dtoesp4) then var_dtoesp4 = 0
	if isnull(var_comi1) then var_comi1 = 0
	if isnull(var_comi11) then var_comi11 = 0
	if isNull(var_almacen_de_carga) then var_almacen_de_carga = ""
	
	if not isnull(var_codcli) and var_codcli <> "" then
		SELECT cuenta INTO :cuenta_cliente FROM genter WHERE empresa = :codigo_empresa AND codigo = :var_codcli AND tipoter = 'C';
		if isnull(cuenta_cliente) OR cuenta_cliente = "" then
			messagebox("Atención","No están definidas las cuentas contables del cliente y no se podrá pasar el pedido. Contacte con Administración.")
			return
		end if
	end if
	
	CHOOSE CASE var_direnvio
	    CASE "N"
		 CASE "S"
		   if trim(var_envio)="" or f_nombre_venenvio(codigo_empresa,var_codcli,var_envio)="" then
		      campo="envio"
		      dato = apartados.pagina_2.dw_pagina2
 		      numero = 2
				MessageBox("Campo obligatorio","El cliente tiene que tener dirección de envio.",information!,Ok!) 
			   apartados.SelectTab(numero)
	         dato.setfocus()
	         dato.SetColumn(campo)
     		   Return
			End if
	    CASE "A"
	        if f_pedido_existe_sn(codigo_empresa,dec(em_anyo.text),dec(sle_valor.text))="N" then 
				if trim(var_envio)="" or f_nombre_venenvio(codigo_empresa,var_codcli,var_envio)="" then		
				   if MessageBox("Control dirección de envio","El cliente tiene direcciones de envio.¿Quiere indicar la dirección?",information!,YesNo!,1) = 1 then
						campo="envio"
						dato = apartados.pagina_2.dw_pagina2
						numero = 2
						apartados.SelectTab(numero)
						dato.setfocus()
						dato.SetColumn(campo)
						Return
					End if
					in_incidencia=Trim(nombre_usuario)+",el Pedido:"+sle_valor.text+" lo ha grabado dirección de envio al clte:"+trim(var_codcli)
				   f_grabar_incidencia("Cabecera pedidos",in_incidencia)
             End if
		 	  else
               if f_pedido_direnvio_sn(codigo_empresa,dec(em_anyo.text),dec(sle_valor.text))<>var_envio then
					   if MessageBox("Control dirección de envio","Usted a variado la direccion de envio.¿Esta usted seguro/a?",information!,YesNo!,2) = 2 then
								campo="envio"
								dato = apartados.pagina_2.dw_pagina2
								numero = 2
								apartados.SelectTab(numero)
								dato.setfocus()
								dato.SetColumn(campo)
								Return
					    else
								in_incidencia=Trim(nombre_usuario)+",al pedido:"+sle_valor.text+" le ha modificado la dir.envio "+ f_pedido_direnvio_sn(codigo_empresa,dec(em_anyo.text),dec(sle_valor.text))+" por "+var_envio
								f_grabar_incidencia("Cabecera pedidos",in_incidencia)
                   End if		   
					End if
	 		End if
   END CHOOSE

	if Trim(var_envio)<>"" then
		if f_pedido_existe_sn(codigo_empresa,dec(em_anyo.text),dec(sle_valor.text))="N" then
				if trim(var_obser)="" then
					dw_pag2.SetItem(1,"observaciones",f_nombre_venenvio(codigo_empresa,var_codcli,var_envio))
				 else
				   var_obser = var_obser + char(13) +&
								   f_nombre_venenvio(codigo_empresa,var_codcli,var_envio)
					dw_pag2.SetItem(1,"observaciones",var_obser)
				End if
		End if
	End if 	
	
	string textoactivo
	IF f_activo_genter(codigo_empresa,"C",var_codcli)= "N" Then
		textoactivo = f_textoactivo_genter(codigo_empresa,"C",var_codcli)
		MessageBox("Cliente Inactivo",textoactivo+" Para pasar el pedido hay que activarlo.",information!,Ok!) 
		cb_salir.TriggerEvent(clicked!)
		Return
	END IF
	
	IF ftc_es_cliente_bloqueado(codigo_empresa, var_codcli) and  apartados.pagina_1.dw_pagina1.object.es_proforma[apartados.pagina_1.dw_pagina1.getrow()] = 'N' Then
		SELECT razon INTO :textoactivo FROM genter WHERE empresa = :codigo_empresa AND codigo = :var_codcli AND tipoter = 'C';
		MessageBox("Pedidos Bloqueados",textoactivo+": No se puede pasar el pedido para el cliente hasta que esté adelantado su pago. Contacte con administración.",information!,Ok!) 
		cb_salir.TriggerEvent(clicked!)
		Return
	END IF
// David 29-01-2007
	if dec(em_anyo.text) <> year (date( apartados.pagina_1.dw_pagina1.object.fpedido[apartados.pagina_1.dw_pagina1.getrow()])) then
		messagebox ("Atención", " El año del pedido debe coincidir con el de la fecha del pedido.")
		campo="fpedido"
		dato = apartados.pagina_1.dw_pagina1
		numero = 1
	End If
// Fin David 29-01-2007
	
	if Trim(var_codpago)="" then
		  campo="codpago"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	End If
	
	if Trim(var_divisa)="" then
		  campo="divisa"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	End If
	
	if Trim(var_tarifa)="" then
		  campo="tarifa"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	End If
	
	if Trim(var_tipiva)="" then
		  campo="tipoiva"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	End If
	
	if Trim(var_codcli)="" then
		  campo="cliente"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
	End If
	
	if Trim(var_codpago)<>"" then
		control_banco = f_cartipodoc_controlbanco(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,var_codpago))
		if control_banco = "S" and Trim(var_bancocobro)="" then
		  campo="banco_de_cobro"
		  dato = apartados.pagina_1.dw_pagina1
		  numero = 1
		End if
	End If
	
	if Trim(var_almacen_de_carga) = "" then
		  campo  = "almacen_de_carga"
		  dato   = apartados.pagina_1.dw_pagina1
		  numero = 1
	End If	
	
	IF Trim(campo)<>"" THEN
	  MessageBox(" "+campo+": Campo obligatorio","Introducir el campo ",Exclamation!, OK!,1)
	  apartados.SelectTab(numero)
	  dato.setfocus()
	  dato.SetColumn(campo)
	  Return
	END IF
		
	dw_pag1.SetItem(1,"deposito",var_deposito)
	dw_pag1.SetItem(1,"almacen_deposito",var_almacen_deposito)
	IF Dec(f_valor_columna(dw_pag2,1,"dtoesp1")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto1","")
	IF Dec(f_valor_columna(dw_pag2,1,"dtoesp2")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto2","")
	IF Dec(f_valor_columna(dw_pag2,1,"dtoesp3")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto3","")
	IF Dec(f_valor_columna(dw_pag2,1,"dtoesp4")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto4","")
   f_asignar_columna(dw_pag1,1,"iva",String(f_iva_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,f_valor_columna(dw_pag1,1,"tipoiva"))))
	
	Select dtopp,cod_pago,agente1,agrupa_referencia,domiciliacion,
	       dtoesp1,dtoesp2,dtoesp3,dtoesp4,comision1,comision11
	Into   :c_dtopp,:c_cod_pago,:c_agente1,:c_refer,:c_domiciliacion,
	       :c_dtoesp1,:c_dtoesp2,:c_dtoesp3,:c_dtoesp4,:c_comi1,:c_comi11
 	from   venclientes
	Where  venclientes.empresa = :codigo_empresa
	And    venclientes.codigo = :var_codcli;
	
	IF IsNull(var_referencia) Then var_referencia = ""
	IF IsNull(c_domiciliacion) Then c_domiciliacion = ""
	if isnull(c_dtoesp1) then c_dtoesp1 = 0
	if isnull(c_dtoesp2) then c_dtoesp2 = 0
	if isnull(c_dtoesp3) then c_dtoesp3 = 0
	if isnull(c_dtoesp4) then c_dtoesp4 = 0
	if isnull(c_comi1)  then c_comi1  = 0
	if isnull(c_comi11) then c_comi11 = 0
	if isnull(var_dtoesp1) then var_dtoesp1 = 0	
	if isnull(var_dtoesp2) then var_dtoesp2 = 0
	if isnull(var_dtoesp3) then var_dtoesp3 = 0
	if isnull(var_dtoesp4) then var_dtoesp4 = 0
	if isnull(var_comi1)   then var_comi1  = 0
	if isnull(var_comi11)  then var_comi11 = 0

	if var_dtoesp1<>c_dtoesp1 or var_dtoesp2<>c_dtoesp2 or var_dtoesp3<>c_dtoesp3 or var_dtoesp4<>c_dtoesp4 then
  		dw_pag2.SetItem(1,"agrupa_exp","N")	
   End if
	if c_domiciliacion<>var_domiciliacion then
		dw_pag2.SetItem(1,"agrupa_exp","N")
	End if
	if var_comi1<>c_comi1 or var_comi11<>c_comi11 then
		dw_pag2.SetItem(1,"agrupa_exp","N")
	END IF
	iF (var_dtopp <> c_dtopp) then 
		dw_pag2.SetItem(1,"agrupa_exp","N")
	END IF
	if (c_cod_pago<> var_codpago) Then
		dw_pag2.SetItem(1,"agrupa_exp","N")
	END IF
END IF 

call super::clicked
end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_int_venped
integer taborder = 0
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_int_venped
integer x = 9
integer y = 12
integer height = 104
end type

event st_empresa::clicked;call super::clicked;str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
 f_activar_campo(sle_valor)
 OpenWithParm(w_lis_venproformas,lstr_param)
 f_activar_campo(sle_valor)
end event

type sle_valor from wc_mantenimientos_tab`sle_valor within w_int_venped
integer x = 585
integer y = 168
integer width = 302
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
string displaydata = "D"
end type

event sle_valor::getfocus;call super::getfocus;dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag2.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag3.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))

end event

type st_1 from wc_mantenimientos_tab`st_1 within w_int_venped
integer x = 37
integer y = 176
integer width = 302
string text = "Pedido:"
alignment alignment = right!
end type

type apartados from wc_mantenimientos_tab`apartados within w_int_venped
integer y = 268
integer width = 3086
integer height = 1800
integer taborder = 20
boolean multiline = true
end type

event apartados::clicked;call super::clicked;IF index = 4 Then
	f_activar_campo(apartados.pagina_4.uo_cliente.em_campo)
END IF
end event

on apartados.create
call super::create
this.Control[]={this.pagina_1,&
this.pagina_2,&
this.pagina_3,&
this.pagina_4,&
this.pagina_5,&
this.pagina_6,&
this.pagina_7,&
this.pagina_8}
end on

on apartados.destroy
call super::destroy
end on

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 3049
integer height = 1672
string text = "Datos Facturación."
dw_res dw_res
end type

on pagina_1.create
this.dw_res=create dw_res
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_res
end on

on pagina_1.destroy
call super::destroy
destroy(this.dw_res)
end on

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 46
integer width = 3017
integer height = 1644
string dataobject = "dw_int_venped5"
end type

event dw_pagina1::clicked;call super::clicked;IF GetRow() = 0  Then return
str_parametros lstr_param
CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_cliente"
 
 lstr_param.i_nargumentos    = 2
 lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
 OpenWithParm(wi_mant_clientes2,lstr_param)  

CASE "pb_envio"
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"envio")
   OpenWithParm(wi_mant_venenvio,lstr_param)  
CASE "pb_correspondencia"
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"correspondencia")
   OpenWithParm(wi_mant_vencorrespondencia,lstr_param)  
CASE "pb_codentrega" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cod_entrega")
	OpenWithParm(wi_mant_vencondentrega,lstr_param)  
CASE "pb_codpago" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"codpago")
	OpenWithParm(wi_mant_carforpag,lstr_param)  

CASE "pb_idioma" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"idioma")
	OpenWithParm(wi_mant_idiomas,lstr_param)  
CASE "pb_tipo_iva" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"tipoiva")
	OpenWithParm(wi_mant_contaiva,lstr_param)  
 
END CHOOSE


end event

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;String var_texto1,var_texto2,var_condicion,var_moneda,var_tarifa,var_idioma
string control_banco, var_codpago,var_cliente

var_texto1  = f_valor_columna(This,This.GetRow(),'textopie1')
var_texto2  = f_valor_columna(This,This.GetRow(),'textopie2')
var_tarifa  = f_valor_columna(This,This.GetRow(),'tarifa')
var_idioma  = f_valor_columna(This,This.GetRow(),'idioma')
var_codpago = f_valor_columna(This,This.GetRow(),'codpago')


IF Trim(var_texto1) = "" or IsNull(var_texto1)   then
	var_texto1 = f_nombre_vencondentrega(codigo_empresa,f_valor_columna(This,This.GetRow(),'cod_entrega'))
   f_asignar_columna(This,This.getrow(),"textopie1",var_texto1)
END IF

IF Trim(var_texto2) = "" or IsNull(var_texto2) then
	var_texto2 = f_nombre_vencondentrega_idioma(codigo_empresa,f_valor_columna(This,This.GetRow(),'cod_entrega'),var_idioma)
   f_asignar_columna(This,This.getrow(),"textopie2",var_texto2)
END IF

var_condicion = f_condicion_vencondentrega(codigo_empresa,f_valor_columna(This,This.GetRow(),'cod_entrega'))
f_asignar_columna(This,This.getrow(),"condicion",var_condicion)
This.SetTabOrder("divisa",90)
IF Trim(var_tarifa) <> "" and Not IsNull(var_tarifa) Then
// Asignamos la moneda del cliente. Santiago. 16/01/01	
//	var_moneda = f_moneda_ventarifas(codigo_empresa,var_tarifa)
	var_moneda = f_moneda_cliente(codigo_empresa,f_valor_columna(This,This.GetRow(),'cliente'))
// Asignamos la moneda del cliente. Santiago. 16/01/01	
	f_asignar_columna(This,This.GetRow(),"divisa",var_moneda)
	setitem(getrow(),"cambio",f_cambio_moneda(var_moneda))
	This.SetTabOrder("divisa",0)
END IF

control_banco = f_cartipodoc_controlbanco(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,var_codpago))

This.SetTabOrder("banco_de_cobro",130)
if control_banco = "N" then
	This.SetTabOrder("banco_de_cobro",0)
	f_asignar_columna(dw_pag1,1,"banco_de_cobro","")
END IF

end event

event dw_pagina1::key;string comision_fija1,comision_fija2,comision_fija3,var_activo,ls_comentario_introduccion_pedidos,ls_tarifa_envio
dec v_riesgo_concedido

bus_filtro=""
bus_titulo=""
valor_empresa = TRUE
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "almacen_de_carga"
		bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
		bus_datawindow   =  "dw_ayuda_almacenes"
	CASE "cliente"
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CLIENTES"
	CASE "almacen_deposito"
		bus_datawindow = "dw_ayuda_depalmacenes"
		bus_filtro     = "codcli = '" + GetItemString(GetRow(),"cliente") + "'"
		bus_titulo = "VENTANA SELECCION DE ALMACENES"	
	CASE "envio"
		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
		bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "correspondencia"
		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
		bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "codpago"
		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
	CASE "agente1"
		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo     = "VENTANA SELECCION DE AGENTES"
	CASE "agente2"
		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo     = "VENTANA SELECCION DE AGENTES"
	CASE "agente3"
		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo     = "VENTANA SELECCION DE AGENTES"
	CASE "idioma"
		bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
		valor_empresa = FALSE		  
	CASE "divisa"
		bus_datawindow = "dw_ayuda_divisas"
		bus_titulo     = "VENTANA SELECCION DE DIVISAS"
		valor_empresa = FALSE
	CASE "tarifa"
		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo     = "VENTANA SELECCION DE TARIFAS"
	CASE "tipoiva"
		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo     = "VENTANA SELECCION DE Tipos de Iva"
		bus_filtro = " ejercicio = "+String(f_ejercicio_activo(codigo_empresa))
	CASE "cod_entrega"
		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo     = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
	CASE "banco_de_cobro"
		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo     = "VENTANA SELECCION BANCOS DE COBRO"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::Key

IF Key = KeyTab! Then
		String codcli
		IF GetRow() =0 Then Return
		AcceptText()
		codcli    = GetItemString(This.GetRow(),"cliente")
		
		if Integer(codcli)=0 then Return
		
		
		CHOOSE CASE GetColumnName()
			
			CASE "cliente"
				String var_Nombre,var_direcc,var_codpostal,var_provincia,var_pais,var_localidad
				str_venped ped
				Integer  var_ejercicio
				String   var_empresa,var_codigo,var_tipoter, nuevo_cliente, cuenta_cliente = ""
				
				nuevo_cliente = f_valor_columna(This,This.GetRow(),'cliente')
				SELECT cuenta INTO :cuenta_cliente FROM genter WHERE empresa = :codigo_empresa AND codigo = :nuevo_cliente and tipoter = 'C';
				if isnull(cuenta_cliente) OR cuenta_cliente = "" then
					messagebox("Atención","No están definidas las cuentas contables del cliente. Contacte con Administración.")
					SetItem(GetRow(),"cliente","")
					return
				end if
				
				var_activo  = f_activo_cliente(codigo_empresa,nuevo_cliente)
				if var_activo = "N" then
					messagebox("Atención","Cliente NO activo")
					SetItem(GetRow(),"cliente","")
				else
					var_ejercicio = f_ejercicio_activo(codigo_empresa)
					IF codcli <> antecliente or IsNull(antecliente) Then
								SELECT venclientes.zona,venclientes.serie,venclientes.agente1,   
										 venclientes.agente2,venclientes.agente3,venclientes.comision1, venclientes.comision2,   venclientes.comision31,
										 venclientes.cod_pago,venclientes.dtopp,venclientes.dtoesp1,   
										 venclientes.dtoesp2, venclientes.tipoiva,
										 venclientes.forma_envio, venclientes.tipo_portes,   
										 venclientes.cod_entrega, venclientes.periodo_fac,   
										 venclientes.explicaciondto1, venclientes.explicaciondto2,   
										 venclientes.tarifa,   
										 venclientes.comision11,      venclientes.comision22,   venclientes.comision31, 
										 venclientes.dtoesp3,         venclientes.dtoesp4,   
										 venclientes.explicaciondto3, venclientes.explicaciondto4,   
										 venclientes.tipodto1,        venclientes.tipodto2,   
										 venclientes.tipodto3,        venclientes.tipodto4,   
										 venclientes.empresa,         venclientes.codigo  ,
										 venclientes.cod_entrega,     venclientes.calculo_dto  ,
										 venclientes.banco_de_cobro,  venclientes.envio,
										 venclientes.correspondencia,venclientes.domiciliacion,venclientes.transportista,
										 venclientes.agrupa,venclientes.periodo_fac,venclientes.deposito,
										 venclientes.calculo_dtoesp,venclientes.agrupa_exp,venclientes.facturar_metros_reales,
										 venclientes.comision_fija1,venclientes.comision_fija2,venclientes.comision_fija3,
										 isnull(venclientes.comentario_introduccion_pedidos,'')
								INTO   :venped.zona, :venped.serie, :venped.agente1, :venped.agente2,:venped.agente3,:venped.comision1,   
										 :venped.comision2,:venped.comision31,:venped.codpago,:venped.dtopp,:venped.dtoesp1,
										 :venped.dtoesp2,:venped.tipoiva, :venped.forma_envio,   
										 :venped.tipo_portes,:venped.cod_entrega,:venped.periodo_fac,
										 :venped.explicaciondto1,:venped.explicaciondto2,   
										 :venped.tarifa,:venped.comision11,:venped.comision22,:venped.comision31,:venped.dtoesp3,   
										 :venped.dtoesp4,:venped.explicaciondto3,:venped.explicaciondto4,
										 :venped.tipodto1,:venped.tipodto2,:venped.tipodto3,:venped.tipodto4,   
										 :venped.empresa,:venped.cliente ,:venped.cod_entrega,
										 :venped.calculo_dto,:venped.banco_de_cobro,
										 :venped.envio,:venped.correspondencia,
										 :venped.domiciliacion,:venped.transportista,
										 :venped.agrupa,:venped.periodo_fac,:venped.deposito,
										 :venped.calculo_dtoesp,:venped.agrupa_exp,:venped.facturar_metros_reales,
										 :comision_fija1,:comision_fija2,:comision_fija3,
										 :ls_comentario_introduccion_pedidos
								FROM   venclientes  
								WHERE  venclientes.empresa = :codigo_empresa 
								AND    venclientes.codigo = :codcli;
								 IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error en Seleccion del cliente",sqlca.SqlErrText)
								 venped.almacen_deposito  = f_depalmacen_cliente(codigo_empresa,venped.cliente)
								 
								if isnull(venped.facturar_metros_reales) then venped.facturar_metros_reales = ""
								if trim(venped.facturar_metros_reales) = "" then venped.facturar_metros_reales = "N"
								
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"cliente",codcli)
			
								Select  genter.empresa,
										  genter.tipoter,
										  genter.codigo,
										  genter.idioma,
										  genter.moneda
								Into    :var_empresa,
										  :var_tipoter,
										  :var_codigo,
										  :venped.idioma,
										  :venped.divisa
								From    genter
								Where   genter.empresa = :codigo_empresa 
								And     genter.tipoter = 'C'
								And     genter.codigo  = :codcli;
				
								SELECT contaiva.iva  INTO :venped.iva  
								FROM contaiva  
								WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
										( contaiva.empresa = :codigo_empresa ) AND  
										( contaiva.tipoiva = :venped.tipoiva )   ;
				  
								apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"codpago",venped.codpago)
								apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"deposito",venped.deposito)
								apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"almacen_deposito",venped.almacen_deposito)
								apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"banco_de_cobro",venped.banco_de_cobro)
								apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"facturar_metros_reales",venped.facturar_metros_reales)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"cliente",venped.cliente)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente1",venped.agente1)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente2",venped.agente2)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente3",venped.agente3)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision1",venped.comision1)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision2",venped.comision2)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision31",venped.comision31)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision11",venped.comision11)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision22",venped.comision22)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision32",venped.comision32)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtopp",venped.dtopp)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp1",venped.dtoesp1)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp2",venped.dtoesp2)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp3",venped.dtoesp3)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp4",venped.dtoesp4)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto1",venped.tipodto1)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto2",venped.tipodto2)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto3",venped.tipodto3)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto4",venped.tipodto4)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto1",venped.explicaciondto1)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto2",venped.explicaciondto2)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto3",venped.explicaciondto3)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto4",venped.explicaciondto4)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"calculo_dto",venped.calculo_dto)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"envio",venped.envio)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"correspondencia",venped.correspondencia)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"domiciliacion",venped.domiciliacion)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"transportista",venped.transportista)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agrupa",venped.agrupa)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agrupa_exp",venped.agrupa_exp)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"cod_entrega",venped.cod_entrega)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"periodo_fac",venped.periodo_fac)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"calculo_dtoesp",venped.calculo_dtoesp)
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision_fija1",comision_fija1)				
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision_fija2",comision_fija2)				
								apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision_fija3",comision_fija3)				
								SetItem(GetRow(),"tipoiva",venped.tipoiva)
								SetItem(GetRow(),"iva",venped.iva)	  
								SetItem(GetRow(),"serie",venped.serie)
								SetItem(GetRow(),"zona",venped.zona)
								SetItem(GetRow(),"forma_envio",venped.forma_envio)
								SetItem(GetRow(),"cod_entrega",venped.cod_entrega)							
								
								if isnull(venped.envio) then venped.envio = ''
								
								if trim(venped.envio) <> "" then
									ls_tarifa_envio = f_venenvio_tarifa(codigo_empresa,codcli,venped.envio)
									
									if ls_tarifa_envio <> '' then 
										venped.tarifa = ls_tarifa_envio
										venped.divisa = f_moneda_ventarifas(codigo_empresa,venped.tarifa)
									end if
								end if
								
								if trim(ls_comentario_introduccion_pedidos) <> "" then
									messagebox("Comentario Introducción Pedidos",ls_comentario_introduccion_pedidos,Exclamation!)
								end if
					End if
			 
					SetItem(GetRow(),"idioma",venped.idioma)
					SetItem(GetRow(),"divisa",venped.divisa)
					setitem(GetRow(),"cambio",f_cambio_moneda(venped.divisa))				
					SetItem(GetRow(),"tarifa",venped.tarifa)
/*					
					antecliente = codcli

					
					v_riesgo_concedido = 0	
					v_riesgo_concedido = f_riesgo_concedio(codigo_empresa,codcli)		
					if v_riesgo_concedido > 0 then
						if f_riesgo_cliente(codigo_empresa,codcli) > v_riesgo_concedido  then
	//						f_mensaje("Atención","El cliente ha superado el riesgo")
							apartados.pagina_1.dw_res.reset()
							apartados.pagina_1.dw_res.visible = TRUE
							apartados.pagina_1.dw_res.enabled = TRUE
							apartados.pagina_1.dw_pagina1.enabled = FALSE
							f_riesgos(codcli)
							dw_res.object.t_total.text = string(dec(dw_res.object.total[1]) - v_riesgo_concedido,"###,###,###,##0.00" )
						end if
					end if
*/					
				end if
		END CHOOSE
		

END IF




end event

event dw_pagina1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "almacen_de_carga"
		bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
		bus_datawindow   =  "dw_ayuda_almacenes"		
	CASE "almacen_deposito"
 		bus_datawindow = "dw_ayuda_depalmacenes"
		bus_filtro     = "codcli = '" + GetItemString(GetRow(),"cliente") + "'"
		bus_titulo = "VENTANA SELECCION DE ALMACENES"
   CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo     = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
   CASE "tipoiva"
      bus_datawindow = "dw_ayuda_contaiva"
    	bus_titulo     = "VENTANA SELECCION DE Tipos de Iva"
  	   bus_filtro = " ejercicio = "+String(f_ejercicio_activo(codigo_empresa))		
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
	CASE "agente3"
		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo     = "VENTANA SELECCION DE AGENTES"
	CASE "idioma"
		bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
		valor_empresa = FALSE		  
	CASE "tarifa"
		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo     = "VENTANA SELECCION DE TARIFAS"
	CASE "divisa"
		bus_datawindow = "dw_ayuda_divisas"
		bus_titulo     = "VENTANA SELECCION DE DIVISA"
		valor_empresa = FALSE
	CASE "banco_de_cobro"
		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo     = "VENTANA SELECCION BANCOS DE COBRO"
	CASE "cliente"
		bus_titulo     = "VENTANA SELECCION CLIENTES"
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
	CASE "envio"
		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
		bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "correspondencia"
		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIRECCIONES CORRESPONDENCIA"
		bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina1::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
//       f_valores_numericos(This,"codpago")
       f_valores_numericos(This,"divisa")
       f_valores_numericos(This,"tarifa")
       f_valores_numericos(This,"cliente")
       f_valores_numericos(This,"almacen_deposito")
      
//---------------------------------------------//
//---------------------------------------------//
end event

event dw_pagina1::getfocus;call super::getfocus;IF apartados.pagina_1.dw_pagina1.GetRow()= 0 Then Return

 antecliente = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),"cliente")
 

end event

event dw_pagina1::itemchanged;call super::itemchanged;Datetime ahora, ahora_fecha
Int anyo, nuevo_anyo
Dec pedido, nuevo_pedido
int anyo_actual
String cliente, textoactivo
Long planificado 
anyo_actual = Year(Today())

if row > 0 then
	if dwo.name = "es_proforma" and data = "N" then
		ahora = Datetime(Today(), Now())
		ahora_fecha = Datetime(Today(), Time(0))
		anyo = this.object.anyo[row]
		pedido = this.object.pedido[row]
		cliente =  this.object.cliente[row]
		IF ftc_es_cliente_bloqueado(codigo_empresa, cliente) Then
			SELECT razon INTO :textoactivo FROM genter WHERE empresa = :codigo_empresa AND codigo = :cliente AND tipoter = 'C';
			MessageBox("Pedidos Bloqueados",textoactivo+": No se puede pasar el pedido para el cliente hasta que esté adelantado su pago. Contacte con administración.",information!,Ok!) 
			this.object.es_proforma[row] = "S"
			Return 2
		END IF
		
		if not isnull(anyo) and anyo > 0 and not isnull(pedido) and pedido > 0 then
			if MessageBox("Atención", "Se va a generar un pedido con fecha de hoy con los datos de la proforma, ¿desea continuar?", Question!, YesNo!, 2) = 2 then
				//this.acceptText()
				//this.object.es_proforma[row] = 'S'
				return 2  // Deja el valor anterior
				//this.acceptText()
			else
				cb_insertar.triggerEvent("clicked")
				
				if integer(em_anyo.text ) < anyo_actual then
					em_anyo.text = String(anyo_actual)
					pb_calculadora.triggerEvent("clicked")
				end if


				nuevo_anyo = Integer(em_anyo.text)
				nuevo_pedido = Dec(sle_valor.text)
				
				UPDATE venped SET anyo = :nuevo_anyo, pedido = :nuevo_pedido, fpedido = :ahora_fecha, es_proforma = 'N'
				WHERE empresa = :codigo_empresa AND anyo = :anyo AND pedido = :pedido USING sqlca;
				
				if SQLCA.sqlcode <> 0 then
					ROLLBACK ;
				else
					UPDATE venliped SET fpedido = :ahora_fecha, fecha_intr = :ahora, anyo = :nuevo_anyo, pedido = :nuevo_pedido 
					WHERE empresa = :codigo_empresa AND anyo = :anyo AND pedido = :pedido USING sqlca;
					if SQLCA.sqlcode <> 0 then  
						ROLLBACK;
					else
						COMMIT;
					end if				
				end if
		//		cb_salir.triggerEvent("clicked")
				
				em_anyo.text = String(year(Today()))
				
				sle_valor.text = String(nuevo_pedido)
				sle_valor.triggerEvent("getfocus")
				sle_valor.triggerEvent("losefocus")
			end if
			
		end if		
		
	elseif dwo.name = "es_proforma" and data = "S" then
		anyo = this.object.anyo[row]
		pedido = this.object.pedido[row]
		if ftc_pedido_en_orden_carga(anyo,pedido) then
			MessageBox("Pedido en Orden de Carga", "No se puede pasar a Proforma de nuevo un pedido con material preparado. Contacte con el almacén.",information!,Ok!) 
			this.object.es_proforma[row] = "N"
			Return 2
		end if
		
		SELECT COUNT(*) INTO :planificado FROM planificacion WHERE empresa = :codigo_empresa AND anyo = :anyo AND pedido = :pedido;
		if planificado > 0 then
			MessageBox("Pedido Planificado", "No se puede pasar a Proforma de nuevo un pedido ya planificado. Contacte con planificación.",information!,Ok!) 
			this.object.es_proforma[row] = "N"
			Return 2
		end if
		
	end if
end if

/*
Datetime ahora, ahora_fecha
Int anyo, nuevo_anyo
Dec pedido, nuevo_pedido
int anyo_actual



if row > 0 then
	if dwo.name = "es_proforma" and data = "N" then
		ahora = Datetime(Today(), Now())
		ahora_fecha = Datetime(Today(), Time(0))
		anyo = this.object.anyo[row]
		pedido = this.object.pedido[row]
		
		if not isnull(anyo) and anyo > 0 and not isnull(pedido) and pedido > 0 then
			if MessageBox("Atención", "Se va a generar un pedido con fecha de hoy con los datos de la proforma, ¿desea continuar?", Question!, YesNo!, 2) = 2 then
				this.acceptText()
				this.object.es_proforma[row] = 'S'
				this.acceptText()
				return
			end if
			
			cb_insertar.triggerEvent("clicked")
						
			em_anyo.text = String(year(Today()))
			pb_calculadora.triggerEvent("clicked")
			nuevo_anyo = Integer(em_anyo.text)
			nuevo_pedido = Dec(sle_valor.text)
			
			//this.acceptText()
			//this.object.fpedido[row] = ahora
			
			UPDATE venped SET anyo = :nuevo_anyo, pedido = :nuevo_pedido, fpedido = :ahora_fecha, es_proforma = 'N'
			WHERE empresa = :codigo_empresa AND anyo = :anyo AND pedido = :pedido;
			
			UPDATE venliped SET fpedido = :ahora_fecha, fecha_intr = :ahora, anyo = :nuevo_anyo, pedido = :nuevo_pedido WHERE empresa = :codigo_empresa AND anyo = :anyo AND pedido = :pedido;
			
			cb_salir.triggerEvent("clicked")
			
			em_anyo.text = String(year(Today()))
			
			sle_valor.text = String(nuevo_pedido)
			sle_valor.triggerEvent("getfocus")
			sle_valor.triggerEvent("losefocus")
			//MessageBox("Atención", "Se ha actualizado la fecha del pedido/proforma y sus lineas a la fecha de hoy")
			//this.acceptText()
		end if		
		
	end if
end if
*/
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 3049
integer height = 1672
string text = "Datos Comerciales"
end type

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 5
integer y = 0
integer width = 2807
integer height = 1600
string dataobject = "dw_int_venped4"
end type

event dw_pagina2::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_agente1'
   
	lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"agente1")
  	OpenWithParm(wi_mant_venagentes,lstr_param)  

CASE 'pb_agente2'
	
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente2")
  	OpenWithParm(wi_mant_venagentes,lstr_param)  
	  
CASE 'pb_agente3'
	
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente3")
  	OpenWithParm(wi_mant_venagentes,lstr_param)  

CASE "pb_envio"
   
	lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"envio")
   OpenWithParm(wi_mant_venenvio,lstr_param)

CASE "pb_correspondencia"

   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"correspondencia")
   OpenWithParm(wi_mant_vencorrespondencia,lstr_param)

CASE "pb_transportista"
  
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)

CASE "pb_tipo_portes"
  
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_portes")
   OpenWithParm(wi_mant_ventipoportes,lstr_param)
	
CASE "pb_domiciliacion"
  
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"domiciliacion")
   OpenWithParm(wi_mant_vendomiciliacion,lstr_param)

END CHOOSE



end event

event dw_pagina2::itemfocuschanged;call super::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE This.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"localidad",var_localidad)   
END IF
END CHOOSE


end event

event dw_pagina2::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo


   CASE "envio"
		   bus_datawindow = "dw_ayuda_venenvio"
			bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      	bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "correspondencia"
			bus_datawindow = "dw_ayuda_vencorrespondencia"
			bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      	bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "domiciliacion"
			bus_datawindow = "dw_ayuda_vendomiciliacion"
			bus_titulo = "VENTANA SELECCION DIRECCIONES DOMICILIACIONES"
	      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "transportista"
			bus_datawindow = "dw_ayuda_ventransportistas"
			bus_titulo = "VENTANA SELECCION DIRECCIONES TRANSPORTISTAS"
	      bus_filtro = ""
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"		
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
		bus_filtro     = ""
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
		bus_filtro     = ""
  CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
		bus_filtro     = ""
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "divisa"
      bus_datawindow = "dw_ayuda_divisas"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"		  
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key

 CHOOSE CASE bus_campo
     CASE "cliente"
	  This.TriggerEvent("itemchanged")
 END CHOOSE

END IF


end event

event dw_pagina2::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
	CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
  CASE "divisa"
      bus_datawindow = "dw_ayuda_divisas"
     	bus_titulo     = "VENTANA SELECCION DE DIVISAS"
   CASE "domiciliacion"
		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DIRECCIONES DOMICILIACIONES"
	   bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
  CASE "transportista"
		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo     = "VENTANA SELECCION DIRECCIONES TRANSPORTISTAS"
	   bus_filtro     = ""
  CASE "envio"
		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
  CASE "correspondencia"
		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
	   bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"		
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina2::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(this,"agente1")
       f_valores_numericos(This,"agente2")
       f_valores_numericos(This,"agente3")
//---------------------------------------------//
//---------------------------------------------//
end event

event dw_pagina2::itemchanged;call super::itemchanged;string ls_cliente,ls_tarifa_envio

if dwo.name = 'envio' then
	venped.envio = data	
	
	ls_cliente = dw_pag1.object.cliente[dw_pag1.getrow()]
	
	if isnull(venped.envio) then venped.envio = ''
	
	if trim(venped.envio) <> "" then
		ls_tarifa_envio = f_venenvio_tarifa(codigo_empresa,ls_cliente,venped.envio)
		
		if ls_tarifa_envio <> '' then 
			venped.tarifa = ls_tarifa_envio
		else
			venped.tarifa = f_tarifa_venclientes(codigo_empresa,ls_cliente)
		end if
	else
		venped.tarifa = f_tarifa_venclientes(codigo_empresa,ls_cliente)
	end if	
	
	venped.divisa = f_moneda_ventarifas(codigo_empresa,venped.tarifa)
	
	dw_pag1.object.divisa[dw_pag1.getrow()] = venped.divisa
	dw_pag1.object.cambio[dw_pag1.getrow()] = f_cambio_moneda(venped.divisa)
	dw_pag1.object.tarifa[dw_pag1.getrow()] = venped.tarifa
	
end if
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 3049
integer height = 1672
string text = "Textos"
end type

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 0
integer y = 0
integer width = 2784
integer height = 1212
string dataobject = "dw_int_venped3"
end type

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer width = 3049
integer height = 1672
string text = "Consultar"
uo_cliente uo_cliente
st_2 st_2
st_4 st_4
end type

on pagina_4.create
this.uo_cliente=create uo_cliente
this.st_2=create st_2
this.st_4=create st_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_cliente
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_4
end on

on pagina_4.destroy
call super::destroy
destroy(this.uo_cliente)
destroy(this.st_2)
destroy(this.st_4)
end on

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer x = 0
integer y = 128
integer width = 2811
integer height = 1024
string dataobject = "dw_int_venped2"
boolean vscrollbar = true
end type

event dw_pagina4::doubleclicked;call super::doubleclicked;IF row=0 then Return
em_anyo.text= String(GetItemNumber(row,"anyo"))
sle_valor.text= String(GetItemNumber(row,"pedido"))
apartados.getParent().TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
apartados.SelectTab(1)
end event

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 3049
integer height = 1672
string text = "~r~n"
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
boolean visible = false
integer x = 0
integer y = 16
integer width = 2235
integer height = 1100
end type

event dw_pagina5::rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina5::clicked;call super::clicked;
datawindow var_datawindow
str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_agente1"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente1")
   OpenWithParm(wi_mant_venagentes,lstr_param)  
CASE "pb_agente2"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente2")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_agente3"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente2")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_cod_pago"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cod_pago")
   OpenWithParm(wi_mant_carforpag,lstr_param)
	CASE "pb_cod_entrega"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cod_pago")
   OpenWithParm(wi_mant_vencondentrega,lstr_param)
END CHOOSE





end event

event dw_pagina5::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "pb_banco_cobro"
  		bus_datawindow = "dw_ayuda_carbancos"
 		bus_titulo = "VENTANA SELECCION BANCOS EMPRESA"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_pagina5::valores_numericos;call super::valores_numericos;f_valores_numericos(This,"cod_pago")
f_valores_numericos(This,"agente1")
f_valores_numericos(This,"agente2")
f_valores_numericos(This,"agente3")
end event

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 3049
integer height = 1672
string text = ""
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
integer width = 2318
end type

event dw_pagina6::rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina6::clicked;call super::clicked;
datawindow var_datawindow
str_parametros lstr_param



lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_zona"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"zona")
   OpenWithParm(wi_mant_venzonas,lstr_param)  
CASE "pb_grupo"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"grupo")
   OpenWithParm(wi_mant_vengrupos,lstr_param)  
CASE "pb_serie"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"serie")
   OpenWithParm(wi_mant_venseries,lstr_param)  
END CHOOSE





end event

event dw_pagina6::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 3049
integer height = 1672
string text = ""
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
integer width = 1911
integer height = 896
end type

event dw_pagina7::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_pagina7::clicked;call super::clicked;
datawindow var_datawindow
str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_transportista"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)
CASE "pb_tarifa"
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tarifa")
	OpenWithParm(wi_mant_ventarifas,lstr_param)
END CHOOSE





end event

event dw_pagina7::rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 3049
integer height = 1672
string text = ""
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
integer x = 87
integer width = 2473
integer height = 1148
end type

type dw_res from u_datawindow within pagina_1
boolean visible = false
integer x = 553
integer y = 232
integer width = 1902
integer height = 536
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "El Cliente ha superado el riesgo"
string dataobject = "dw_foto_cliente_desde_pedidos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;if dwo.name = "cb_aceptar" then
	apartados.pagina_1.dw_res.visible = FALSE
	apartados.pagina_1.dw_res.enabled = FALSE
	apartados.pagina_1.dw_pagina1.enabled = TRUE
	apartados.pagina_1.dw_pagina1.SetFocus()
	apartados.pagina_1.dw_pagina1.SetColumn("fpedido")

	
	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 	   SENDMIME      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

	string v_de, v_para, v_copia, v_copia_oculta, v_asunto, v_mensaje
	
//	v_de = "info@tendenciasceramicas.com"
//	v_para = "pmuseros@tendenciasceramicas.com"
//	v_copia = "dmartinez@tendenciasceramicas.com"
//	v_asunto = apartados.pagina_1.dw_pagina1.object.razon[apartados.pagina_1.dw_pagina1.GetRow()]+" ha superado el riesgo."	
//	v_mensaje = v_asunto+"~n~nPedido: "+em_anyo.text+"/"+sle_valor.text+"~n~nUSUARIO: "+nombre_usuario
//		
//	f_SendMime (v_de, v_para, v_copia, v_asunto, v_mensaje)

	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	
	
//	
//	
//	mailSession mSes
//	mailReturnCode mRet
//	mailMessage mMsg
//	string direccion
//	
//	direccion = "dmartinez@tendenciasceramicas.com; dmartinezmart@terra.es"
//
//	// Create a mail session
//	mSes = create mailSession
//
//	// Log on to the session
//	mRet = mSes.mailLogon(mailNewSession!)
//
//	IF mRet <> mailReturnSuccess! THEN
//		 MessageBox("Mail", 'Logon failed.')
//		 RETURN
//	END IF
//	
//	// Populate the mailMessage structure
////	mMsg.address = direccion
//	mMsg.Subject = 'Informe de Riesgo de Clientes.' 
//	mMsg.NoteText = 'Luncheon at 12:15'
////	mMsg.RecipientType = mailTo!
//	mMsg.Recipient[1].name = 'dmartinez@tendenciasceramicas.com'
//	mMsg.Recipient[2].name = 'Shaw, Sue'
//
//	// Send the mail
//	mRet = mSes.mailSend(mMsg)
//	IF mRet <> mailReturnSuccess! THEN
//		 MessageBox("Mail Send", 'Mail not sent')
//		 RETURN
//	END IF
//	
//	mSes.mailLogoff()
//	
//	DESTROY mSes
	

	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 	ENVIO POR CORREO @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*
	string destino, asunto, direccion
	
	asunto = " El cliente x ha sobrepasado el riesgo"
	direccion = "dmartinez@tendenciasceramicas.com; dmartinezmart@terra.es"
	if direccion <> '' then
	
		mailsession ms 
		mailrecipient mr 
		mailmessage mm 
		mailfiledescription md 
		ms = create mailsession 
		
		if ms.maillogon() <> mailreturnsuccess! then 
		messagebox('E-MAIL STARTUP ERROR!', 'Error on MailLogon') 
		return 
		end if 
		
		//mr.name = 'dmartinezmart@terra.es' 
		mr.address = direccion
		mr.recipienttype = mailto! 
		
//		md.filetype = mailattach! 
//		md.pathname = destino
//		md.filename = destino
//		md.position = -1 
		
		mm.notetext = asunto 
		mm.subject = 'Informe de Riesgo de Clientes.' 
		mm.recipient[1] = mr 
		mm.attachmentfile[1] = md 
		
		if ms.mailsend(mm) <> mailreturnsuccess! then 
		messagebox('E-MAIL SEND ERROR!', 'Error in MailSend') 
		return 
		end if 
		
		ms.maillogoff() 
		destroy ms 
	else
		messagebox("Aviso", "Introduzca una dirección de correo")
	end if
	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	

	*/
end if
end event

type uo_cliente from u_em_campo_2 within pagina_4
integer x = 256
integer y = 24
integer width = 1934
integer height = 88
integer taborder = 3
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
dw_pag4.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;
   ue_titulo     = "AYUDA SELECCION DE CLIENTES"
	ue_datawindow = "dw_ayuda_clientes"
	ue_filtro     = ""



 
        
end event

type st_2 from statictext within pagina_4
integer x = 23
integer y = 32
integer width = 219
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
boolean focusrectangle = false
end type

type st_4 from statictext within pagina_4
integer x = 32
integer y = 1212
integer width = 1760
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 553648127
string text = "* No se listarán líneas de pedido que contengan artículos sin alta. "
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_int_venped
integer x = 343
integer y = 168
integer width = 233
integer taborder = 0
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#,###"
string displaydata = ""
end type

type pb_calculadora from u_calculadora within w_int_venped
event clicked pbm_bnclicked
integer x = 891
integer y = 164
integer taborder = 0
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
IF Trim(em_anyo.text)=""  THEN Return

dec{0} n_pedido
Dec{0} registros,numero,anyo
String  var_empresa
Int existe_pedido
str_colisiones param_colisiones
transaction transaccion

registros = 0

//anyo = year(Today()) // Dec(em_anyo.text)
if em_anyo.text = '' or isnull(em_anyo.text) then
	anyo = year(Today()) // Dec(em_anyo.text)
	em_anyo.text = String(anyo)
else
	anyo = dec(em_anyo.text)
end if

f_crear_transaccion(transaccion,"","",false,"TS","")

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "venparamped"
param_colisiones.campo = "pedido"
param_colisiones.filtro =  "anyo = "+string(anyo)
param_colisiones.buscar_huecos = false

CONNECT USING transaccion;

registros = long ( f_colisiones ( transaccion, param_colisiones)) 

UPDATE venparamped
SET    pedido = :registros  
WHERE  venparamped.empresa = :codigo_empresa
And    venparamped.anyo    = :anyo
USING transaccion;

COMMIT USING transaccion;
DISCONNECT USING transaccion;

destroy transaccion

calculadora_pulsada = true

//  SELECT venparamped.pedido
//    INTO :registros  
//    FROM venparamped  
//   WHERE venparamped.empresa = :codigo_empresa  
//   And   venparamped.anyo    = :anyo;
//
//   IF IsNull(registros) Then registros=0
//	
////Corrección para evitar pedidos vacios **************************************************************
//SELECT COUNT(*) INTO :existe_pedido FROM venped WHERE empresa  = :codigo_empresa AND anyo = :anyo AND pedido = :registros;
//if existe_pedido = 1 then
//	  registros=registros + 1
//	  If Sqlca.Sqlcode=100 Then
//			 INSERT INTO venparamped
//					  (empresa,anyo,pedido)  
//			 VALUES (:codigo_empresa,:anyo,:registros );
//			 COMMIT;
//		END IF
//end if
////FIN Corrección para evitar pedidos vacios **************************************************************
//	
//   n_pedido= registros
//
//   Select count(*) Into :numero From venped
//   Where   venped.empresa   = :codigo_empresa
//   And     venped.anyo      = :anyo
//   And     venped.pedido    = :n_pedido;
//   If IsNull(numero) Then numero=0
//   If numero<>0 Then
//       Select max((venped.pedido)+1)
//       Into   :registros
//       From   venped
//       Where  venped.empresa = :codigo_empresa
//       And    venped.anyo    = :anyo;
//       //registros= Dec(sle_valor.text)
//   End If
//   UPDATE venparamped
//   SET    pedido = :registros  
//   WHERE  venparamped.empresa = :codigo_empresa
//   And    venparamped.anyo    = :anyo;
//   COMMIT;

   sle_valor.text=String(registros,f_mascara_decimales(0))
   apartados.TriggerEvent("pulsar_datawindow")
end event

type cb_lineas from u_boton within w_int_venped
event clicked pbm_bnclicked
integer x = 1175
integer y = 176
integer width = 306
integer height = 76
integer taborder = 0
string text = "F6 lineas"
end type

event clicked;call super::clicked;IF This.enabled = FALSE THEN RETURN
IF apartados.pagina_1.dw_pagina1.GetRow() = 0 Then Return
Integer anyo
Dec     pedido
String  cliente

anyo    = Integer(em_anyo.text)
pedido  = Dec(sle_valor.text)

Select venped.pedido,venped.cliente Into :pedido,:cliente from venped
where  venped.empresa = :codigo_empresa
and    venped.anyo    = :anyo
and    venped.pedido  = :pedido;

IF SQLCA.SQLCODE = 100 Then
   MessageBox("Codigo del pedido no existe","Introduzca el pedido",Exclamation!, OK!,1)
   f_activar_campo(sle_valor)
   Return
END IF

titulo        =  Parent.title

longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(String(dec(em_anyo.text))))
criterio[2]   =  Trim(String(Dec(em_anyo.text)))+space(20-longitud)
longitud      =  len(trim(String(Dec(sle_valor.text))))
criterio[3]   =  trim(String(Dec(sle_valor.text)))+space(20-longitud)
seleccion[1]     =  criterio[1]+criterio[2]+criterio[3]
tabla[1]         = "venped"
IF NOT f_bloquear(tabla[1],seleccion[1],titulo) THEN
 COMMIT;
 str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=String(Dec(em_anyo.text))
 lstr_param.s_argumentos[3]=String(Dec(sle_valor.text))
 f_activar_campo(sle_valor)
 OpenWithParm(w_int_venliped,lstr_param)
 
 
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 	   SENDMIME      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

string codcli
dec v_riesgo_concedido 

codcli    = apartados.pagina_1.dw_pagina1.object.cliente[apartados.pagina_1.dw_pagina1.GetRow()]

v_riesgo_concedido = 0	
v_riesgo_concedido = f_riesgo_concedio(codigo_empresa,codcli)		
if v_riesgo_concedido > 0 then
	if f_riesgo_cliente(codigo_empresa,codcli) > v_riesgo_concedido  then
		apartados.pagina_1.dw_res.reset()
		apartados.pagina_1.dw_res.visible = TRUE
		apartados.pagina_1.dw_res.enabled = TRUE
		apartados.pagina_1.dw_pagina1.enabled = FALSE
		f_riesgos(codcli)
		apartados.pagina_1.dw_res.object.t_total.text = string(dec(apartados.pagina_1.dw_res.object.total[1]) - v_riesgo_concedido,"###,###,###,##0.00" )
	end if
else

	messagebox("Atención","El cliente no tiene riesgo concedido", Exclamation!, OK!, 1)
end if

/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/ 

 Return
END IF
 f_activar_campo(sle_valor)
end event

type dw_proceso from datawindow within w_int_venped
boolean visible = false
integer x = 2245
integer y = 28
integer width = 110
integer height = 72
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_proceso_venliproformas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_imprimir from upb_imprimir within w_int_venped
integer x = 1010
integer y = 164
integer taborder = 0
end type

event clicked;call super::clicked; IF Trim(sle_valor.text) = "" THEN Return
str_parametros pa
Dec{0} anyo,pedido
anyo   = Dec(em_anyo.text)
pedido = Dec(sle_valor.text)
dw_report.Retrieve(codigo_empresa,anyo,pedido)
pa.s_listado = dw_report.DataObject
OpenWithParm(w_impresoras_v2,dw_report)

f_activar_campo(sle_valor)
end event

type cb_1 from u_boton within w_int_venped
integer x = 2400
integer y = 176
integer width = 352
integer height = 76
integer taborder = 0
string text = "&Or.Preparac"
end type

event clicked;str_parametros lstr_param
string cliente_aux,serie

IF apartados.pagina_1.dw_pagina1.GetRow() = 0 Then Return
 // control de imprimir
 Integer veces
 veces = apartados.pagina_1.dw_pagina1.GetItemNumber(apartados.pagina_1.dw_pagina1.GetRow(),'veces')	
 if veces>0 then
	 if acceso<>"1" then
		 f_mensaje("¡ A t e n c i ó n !","Usted no tiene acceso para volver a imprimirlo.")
		 f_activar_campo(sle_valor)
		 Return
	End if
 End if
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=String(Dec(em_anyo.text),"######")
 lstr_param.s_argumentos[3]=String(Dec(sle_valor.text),"######")
 f_activar_campo(sle_valor)

 
 OpenWithParm(w_list_preparacion_pedido,lstr_param)
 
 dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
 
 cliente_aux = f_cliente_venped(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
 serie       = f_serie_venclientes(codigo_empresa,cliente_aux)
 if serie = "1" then
    f_imprime_nombre_cliente(dw_nombre_cliente,cliente_aux,Dec(em_anyo.text),Dec(sle_valor.text))
end if
 
end event

type dw_report from datawindow within w_int_venped
boolean visible = false
integer x = 2432
integer y = 28
integer width = 110
integer height = 72
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_venliped"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_int_venped
integer x = 1157
integer y = 136
integer width = 1723
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_3 from statictext within w_int_venped
integer x = 896
integer y = 128
integer width = 91
integer height = 40
integer textsize = -6
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "F2"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_nombre_cliente from datawindow within w_int_venped
boolean visible = false
integer x = 2619
integer y = 28
integer width = 110
integer height = 72
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_nombre_clientes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_orden from statictext within w_int_venped
boolean visible = false
integer x = 2071
integer y = 288
integer width = 814
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 553648127
string text = "EN ORDEN DE CARGA"
boolean focusrectangle = false
end type

type pb_duplicar from picturebutton within w_int_venped
integer x = 2752
integer y = 164
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "C:\bmp\COPY1.BMP"
alignment htextalign = left!
string powertiptext = "Duplicar Pedido"
end type

event clicked;Integer numero,v_anyo,li_indice,li_total,li_linea
Dec{0}  v_pedido
string  ls_sel
boolean lb_correcto = true

str_venped   lstr_venped
str_venliped lstr_venliped

datastore ds_datos

v_anyo   = Dec(em_anyo.text)
v_pedido = Dec(sle_valor.text)


Select isnull(Count(*),0) 
Into   :numero 
From   venliped
Where  venliped.empresa = :codigo_empresa
And    venliped.anyo    = :v_anyo
And    venliped.pedido  = :v_pedido;

if numero > 0 then
	if messagebox("Confirmación","¿Desea duplicar el pedido seleccionado?",Question!,YesNo!,1) = 1 then
		if f_cargar_str_venped(codigo_empresa,v_anyo,v_pedido,lstr_venped) then
			//Nuevo pedido
			long registros
			str_colisiones param_colisiones
			transaction transaccion
						
			lstr_venped.anyo = year(today())			
			lstr_venped.fpedido = datetime(today())
			lstr_venped.usuario_pedido = nombre_usuario
			
			f_crear_transaccion(transaccion,"","",false,"TS","")
			
			param_colisiones.empresa = codigo_empresa
			param_colisiones.tabla = "venparamped"
			param_colisiones.campo = "pedido"
			param_colisiones.filtro =  "anyo = "+string(lstr_venped.anyo)
			param_colisiones.buscar_huecos = false
			
			CONNECT USING transaccion;
			
			registros = long ( f_colisiones ( transaccion, param_colisiones)) 
			
			UPDATE venparamped
			SET    pedido = :registros  
			WHERE  venparamped.empresa = :codigo_empresa
			And    venparamped.anyo    = :lstr_venped.anyo
			USING transaccion;
			
			COMMIT USING transaccion;
			DISCONNECT USING transaccion;
			
			destroy transaccion
						
   		lstr_venped.pedido = registros
			lstr_venped.es_proforma = 'S'
			//Nuevo pedido
			
			if f_insertar_venped(lstr_venped) then
				ls_sel = "select venliped.linea from venliped where venliped.empresa = '"+codigo_empresa+"' and venliped.anyo = "+string(v_anyo,"###0")+" and venliped.pedido = "+string(v_pedido,"#####0")+" order by venliped.linea"
				
				li_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
				
				for li_indice = 1 to li_total
					li_linea = ds_datos.object.linea[li_indice]
					
					if f_cargar_str_venliped(codigo_empresa,v_anyo,v_pedido,li_linea,lstr_venliped) then
						lstr_venliped.anyo    = lstr_venped.anyo
						lstr_venliped.pedido  = lstr_venped.pedido
						lstr_venliped.fpedido = lstr_venped.fpedido
						if isnull(lstr_venliped.articulo) then lstr_venliped.articulo = ""
						
						if lstr_venliped.articulo <> "" then lstr_venliped.situacion = 'F'
						
						if f_insertar_venliped(lstr_venliped) then
							
						else
							messagebox("¡Error!","No se puede insertar la linea, no se puede duplicar.")
							lb_correcto = false
						end if
					else
						messagebox("¡Error!","No se puede leer la linea, no se puede duplicar.")
						lb_correcto = false
					end if
				next
				
				destroy ds_datos
				
				if lb_correcto then
					commit;
					
					window lw_ventana 
					str_parametros lstr_param
					
					lstr_param.i_nargumentos=3
					lstr_param.s_argumentos[2]=String(lstr_venped.anyo)
					lstr_param.s_argumentos[3]=String(lstr_venped.pedido)
					
					OpenWithParm(lw_ventana, lstr_param , "w_int_venped")					
					
				else
					rollback;
				end if
			else
				messagebox("¡Error!","No se puede insertar la cabecera, no se puede duplicar.")
				lb_correcto = false
			end if
			
		else
			messagebox("¡Error!","No se puede leer la cabecera, no se puede duplicar.")
			lb_correcto = false
		end if
	end if
else
	messagebox("¡Error!","Pedido sin lineas, no se puede duplicar.")
end if
end event


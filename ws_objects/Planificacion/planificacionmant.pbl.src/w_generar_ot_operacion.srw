$PBExportHeader$w_generar_ot_operacion.srw
forward
global type w_generar_ot_operacion from wi_mvent_con_empresa
end type
type cb_generar from commandbutton within w_generar_ot_operacion
end type
type descripcion_art from statictext within w_generar_ot_operacion
end type
end forward

global type w_generar_ot_operacion from wi_mvent_con_empresa
integer width = 2501
integer height = 1084
cb_generar cb_generar
descripcion_art descripcion_art
end type
global w_generar_ot_operacion w_generar_ot_operacion

type variables
boolean volver_a_descripcion_abr
end variables

on w_generar_ot_operacion.create
int iCurrent
call super::create
this.cb_generar=create cb_generar
this.descripcion_art=create descripcion_art
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_generar
this.Control[iCurrent+2]=this.descripcion_art
end on

on w_generar_ot_operacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_generar)
destroy(this.descripcion_art)
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_generar.visible = false;
end choose
istr_parametros.s_titulo_ventana = "Generar OT de una operación"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)

f_activar_campo(sle_valor)

end event

event ue_recuperar;// Hacemos un Retrieve de todos los DataWindowsChild, antes de hacer el del padre,
// para que no nos pida parámetros al ejecutar

DataWindowChild ldw_Hijo 
string v_version

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "no_tabla"


dw_1.GetChild("version",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa,sle_valor.text)

if dw_1.GetRow() > 0 then
	v_version = dw_1.object.version[dw_1.GetRow()]
else
	v_version = "1"
end if

dw_1.GetChild("ordenoperacion",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa,sle_valor.text,v_version)

call super::ue_recuperar
end event

event activate;call super::activate;w_generar_ot_operacion = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_generar_ot_operacion
integer x = 251
integer y = 328
integer width = 1687
integer height = 488
integer taborder = 20
string dataobject = "dw_generar_ot_operacion"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_generar_ot_operacion
integer x = 110
integer y = 176
integer width = 261
string text = "Codigo:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_generar_ot_operacion
boolean visible = false
integer x = 1298
integer y = 312
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_generar_ot_operacion
boolean visible = false
integer x = 1294
integer y = 424
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_generar_ot_operacion
integer x = 375
integer y = 176
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA DE ARTICULOS"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro = ""

//isle_campo = sle_valor
valor_empresa = TRUE

end event

event sle_valor::losefocus;call super::losefocus;string v_descripcion

select descripcion
into :v_descripcion
from articulos
where codigo = :sle_valor.text
and empresa = :codigo_empresa;

descripcion_art.text = v_descripcion






end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_generar_ot_operacion
integer x = 1979
integer y = 392
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_generar_ot_operacion
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_generar_ot_operacion
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_generar_ot_operacion
integer x = 18
integer width = 2313
integer height = 80
end type

type cb_generar from commandbutton within w_generar_ot_operacion
integer x = 1975
integer y = 500
integer width = 407
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar"
end type

event clicked;datastore lineas_pedido, operaciones
date v_f_entrega
boolean bien = True
dec i,j, total_lineaspedido, total_operaciones, ordent, v_cantidad, v_ordenoperacion
int v_pedido, v_linped, v_anyo, maximo_orden, plazo_entrega = 21, v_factor
string v_operacion, tipooperacion, articulo_linea, v_base, v_formato, v_version = "1", v_lineaprod = "1"
string v_descripcion_formato, v_ajuste, art_encajado
long   ll_lote
int    li_calibre

dw_1.AcceptText ()

if sle_valor.text = "" then
	messagebox ("Aviso","Es obligatorio introducir un articulo")
	return
end if
if dw_1.object.version[1] = "" or isnull(dw_1.object.version[1]) then
	messagebox ("Aviso","Es obligatorio introducir la version")
	return
end if

if dw_1.object.lote[1] = "" or isnull(dw_1.object.lote[1]) then
	messagebox ("Aviso","Es obligatorio introducir el lote")
	return
end if

v_lineaprod = "1"

articulo_linea = sle_valor.text
v_version = dw_1.object.version[1]
v_operacion = string(dw_1.object.ordenoperacion[1]) ;
v_pedido = 0
v_linped = f_numero_linea_pedido_interno()
v_anyo = year(today())
v_cantidad = dw_1.object.cantidad[1] 
v_ajuste = 'S'
if not isnull(dw_1.object.ajuste[1] ) then
	v_ajuste = dw_1.object.ajuste[1] 
end if
setnull(v_f_entrega)

ll_lote    = dec(dw_1.object.lote[1])
li_calibre = 5 //dw_1.object.calibre[1] 

// Pasamos factor para que no casque la función generer OT. Este manteniento desaparecerá. David 07-06-05
decimal factor
integer nivel

nivel = 0

if f_generar_ots(articulo_linea, v_version, v_operacion, v_pedido, v_linped, v_anyo, v_cantidad, v_f_entrega, v_ajuste, art_encajado, factor, nivel, ll_lote, li_calibre) then
	messagebox("AVISO", "Se han generado las OT con éxito.")
else
	messagebox("ERROR", "No se han generado las OT.")	
end if

end event

type descripcion_art from statictext within w_generar_ot_operacion
integer x = 645
integer y = 180
integer width = 1280
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type


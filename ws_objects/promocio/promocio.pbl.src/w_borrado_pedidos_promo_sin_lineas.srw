$PBExportHeader$w_borrado_pedidos_promo_sin_lineas.srw
forward
global type w_borrado_pedidos_promo_sin_lineas from w_int_con_empresa
end type
type pb_2 from upb_salir within w_borrado_pedidos_promo_sin_lineas
end type
type cb_1 from u_boton within w_borrado_pedidos_promo_sin_lineas
end type
end forward

global type w_borrado_pedidos_promo_sin_lineas from w_int_con_empresa
integer x = 5
integer y = 792
integer width = 2903
integer height = 1592
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_1 cb_1
end type
global w_borrado_pedidos_promo_sin_lineas w_borrado_pedidos_promo_sin_lineas

type variables
String	is_codigo,ante_articulo
String  devolver,var_envio
end variables

event open;call super::open;This.title = "PROCESO BORRADO PEDIDOS SIN LINEAS"
istr_parametros = Message.PowerObjectParm

 
end event

on w_borrado_pedidos_promo_sin_lineas.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
end on

on w_borrado_pedidos_promo_sin_lineas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
end on

event activate;call super::activate;w_borrado_pedidos_promo_sin_lineas = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_borrado_pedidos_promo_sin_lineas
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_borrado_pedidos_promo_sin_lineas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_borrado_pedidos_promo_sin_lineas
integer y = 20
integer width = 2587
end type

type pb_2 from upb_salir within w_borrado_pedidos_promo_sin_lineas
integer x = 2743
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type cb_1 from u_boton within w_borrado_pedidos_promo_sin_lineas
integer x = 73
integer y = 152
integer width = 2592
integer height = 1200
integer taborder = 10
integer textsize = -18
string text = "Borra pedidos promoción sin lineas "
end type

event clicked;call super::clicked;DataStore dw
Dec r,r1,vanyo,vpedido,numero
String  sel,vempresa
sel = "Select empresa,anyo,pedido from promped order by empresa,anyo,pedido"
dw = f_cargar_cursor(sel)

For r = 1 To dw.RowCOunt()
	f_mensaje_proceso("Pedido: "+STring(vpedido,"###"),r,dw.RowCount())
	vempresa = dw.GetItemString(r,"empresa")
	vanyo    = dw.GetItemNumber(r,"anyo")
	vpedido  = dw.GetItemNumber(r,"pedido")
	
	Select count(*) Into :numero From promlinped
	Where  empresa = :vempresa
	And    anyo    = :vanyo
	And    pedido  = :vpedido;
	IF IsNull(numero) Then numero = 0
	IF numero =0 Then
		Delete From promped
		Where  promped.empresa = :vempresa
		And    promped.anyo    = :vanyo
		ANd    promped.pedido  = :vpedido;
		COMMIT;
	END IF
Next
end event


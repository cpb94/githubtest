$PBExportHeader$w_int_cambio_tar_clientes.srw
forward
global type w_int_cambio_tar_clientes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_cambio_tar_clientes
end type
type dw_proceso from datawindow within w_int_cambio_tar_clientes
end type
type cb_1 from u_boton within w_int_cambio_tar_clientes
end type
type st_2 from statictext within w_int_cambio_tar_clientes
end type
type em_tarifa from u_em_campo within w_int_cambio_tar_clientes
end type
type st_nombre_tarifa from statictext within w_int_cambio_tar_clientes
end type
type st_moneda_tarifa from statictext within w_int_cambio_tar_clientes
end type
type dw_clientes from datawindow within w_int_cambio_tar_clientes
end type
type dw_preliminar from datawindow within w_int_cambio_tar_clientes
end type
end forward

global type w_int_cambio_tar_clientes from w_int_con_empresa
integer width = 2656
integer height = 1632
pb_1 pb_1
dw_proceso dw_proceso
cb_1 cb_1
st_2 st_2
em_tarifa em_tarifa
st_nombre_tarifa st_nombre_tarifa
st_moneda_tarifa st_moneda_tarifa
dw_clientes dw_clientes
dw_preliminar dw_preliminar
end type
global w_int_cambio_tar_clientes w_int_cambio_tar_clientes

type variables

end variables

forward prototypes
public subroutine f_control ()
public subroutine f_cambiar ()
end prototypes

public subroutine f_control ();dw_preliminar.Retrieve(codigo_empresa)


end subroutine

public subroutine f_cambiar ();Integer registros,registro,bien
String var_cliente,var_nueva_tarifa
bien = 0
var_nueva_tarifa = em_tarifa.text
registros = dw_proceso.Retrieve(codigo_empresa,dw_preliminar.GetItemString(dw_preliminar.GetRow(),"ventarifas_codigo"))
For registro = 1 To registros
 var_cliente = dw_proceso.GetItemString(registro,"codigo")
   UPDATE venclientes  
     SET tarifa = :var_nueva_tarifa  
   WHERE ( venclientes.empresa = :codigo_empresa ) AND  
         ( venclientes.codigo = :var_cliente )   ;
			IF Sqlca.Sqlcode <> 0 Then bien = 1

f_contador_procesos(registro,registros)
Next

If bien = 1 Then
	RollBack;
	f_mensaje("Error en proceso","El proceso no se actualiza")
ELSE
	Commit;
END IF
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Asignación tarifas a clientes"
This.title=istr_parametros.s_titulo_ventana
dw_preliminar.SetTransObject(SQLCA)
dw_clientes.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_preliminar.SetRowFocusIndicator(Hand!)

f_control()
If dw_preliminar.RowCount() <> 0 then dw_preliminar.SetRow(1)
end event

on ue_listar;//dw_report  = dw_detalle
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end on

on w_int_cambio_tar_clientes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_proceso=create dw_proceso
this.cb_1=create cb_1
this.st_2=create st_2
this.em_tarifa=create em_tarifa
this.st_nombre_tarifa=create st_nombre_tarifa
this.st_moneda_tarifa=create st_moneda_tarifa
this.dw_clientes=create dw_clientes
this.dw_preliminar=create dw_preliminar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.em_tarifa
this.Control[iCurrent+6]=this.st_nombre_tarifa
this.Control[iCurrent+7]=this.st_moneda_tarifa
this.Control[iCurrent+8]=this.dw_clientes
this.Control[iCurrent+9]=this.dw_preliminar
end on

on w_int_cambio_tar_clientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_proceso)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.em_tarifa)
destroy(this.st_nombre_tarifa)
destroy(this.st_moneda_tarifa)
destroy(this.dw_clientes)
destroy(this.dw_preliminar)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_cambio_tar_clientes
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_cambio_tar_clientes
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_cambio_tar_clientes
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_cambio_tar_clientes
integer x = 2482
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_proceso from datawindow within w_int_cambio_tar_clientes
boolean visible = false
integer x = 462
integer y = 12
integer width = 494
integer height = 120
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_venclientes_tarifa"
boolean livescroll = true
end type

type cb_1 from u_boton within w_int_cambio_tar_clientes
integer x = 2107
integer y = 196
integer height = 92
integer taborder = 20
string text = "&Procesar"
end type

event clicked;call super::clicked;IF dw_preliminar.GetRow()=0 then Return
IF Trim(em_tarifa.text) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca la nueva tarifa")
	f_activar_campo(em_tarifa)
	Return
END IF	
f_cambiar()
f_control()



end event

type st_2 from statictext within w_int_cambio_tar_clientes
integer x = 32
integer y = 132
integer width = 206
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_tarifa from u_em_campo within w_int_cambio_tar_clientes
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 261
integer y = 128
integer width = 320
integer taborder = 10
end type

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE TARIFAS"
		ue_datawindow = "dw_ayuda_ventarifas"
		ue_filtro     = ""
  


 
        
end on

event modificado;call super::modificado;st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
IF Trim(st_nombre_tarifa.text)="" THEN 
 IF Trim(em_tarifa.text)<>"" Then  f_activar_campo(em_tarifa)
 em_tarifa.text=""
END IF

st_moneda_tarifa.text=f_nombre_moneda(f_moneda_ventarifas(codigo_empresa,em_tarifa.text))


end event

type st_nombre_tarifa from statictext within w_int_cambio_tar_clientes
integer x = 603
integer y = 128
integer width = 1399
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_moneda_tarifa from statictext within w_int_cambio_tar_clientes
integer x = 603
integer y = 224
integer width = 923
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
end type

type dw_clientes from datawindow within w_int_cambio_tar_clientes
boolean visible = false
integer x = 46
integer y = 320
integer width = 2514
integer height = 1064
string dataobject = "dw_con_tarifas_clientes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event clicked;dw_clientes.visible = FALSE
em_tarifa.enabled   = TRUE
cb_1.enabled        = TRUE
end event

type dw_preliminar from datawindow within w_int_cambio_tar_clientes
integer x = 59
integer y = 328
integer width = 2464
integer height = 1028
boolean bringtotop = true
string dataobject = "dw_int_cambio_tar_clientes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;if row=0 Then Return

String cod_tarifa

cod_tarifa  = dw_preliminar.GetItemString(Row,"ventarifas_codigo")

dw_clientes.visible = TRUE
em_tarifa.enabled   = FALSE
cb_1.enabled        = FALSE

dw_clientes.Retrieve(codigo_empresa,cod_tarifa)
end event


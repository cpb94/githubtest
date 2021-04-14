$PBExportHeader$w_con_stock_mp.srw
forward
global type w_con_stock_mp from w_int_con_empresa
end type
type st_3 from statictext within w_con_stock_mp
end type
type pb_2 from upb_salir within w_con_stock_mp
end type
type uo_mp from u_em_campo_2 within w_con_stock_mp
end type
type dw_1 from u_datawindow_consultas within w_con_stock_mp
end type
type dw_detalle from datawindow within w_con_stock_mp
end type
end forward

global type w_con_stock_mp from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2894
integer height = 1332
string title = "Consulta de Movimientos"
string icon = "Application!"
st_3 st_3
pb_2 pb_2
uo_mp uo_mp
dw_1 dw_1
dw_detalle dw_detalle
end type
global w_con_stock_mp w_con_stock_mp

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio,var_caja
Integer   var_calibre
String  devolver,var_tono
end variables

forward prototypes
public subroutine f_control ()
public function boolean f_modificacion_art ()
end prototypes

public subroutine f_control ();String  referencia,tipo_pallet,nombre_calidad,nombre_tipo_pallet,&
	calidad,caja,tono
dec{2}  existencias,disponible,preparado,reservado
Integer calibre,x1

dw_1.SetRedraw(False)
dw_detalle.SetRedraw(False)

dw_1.SetFilter("")											  
dw_1.Filter()

IF dw_1.Retrieve(codigo_empresa,uo_mp.em_codigo.text) = 0 Then 
	dw_detalle.reset()
	dw_1.SetRedraw(True)
	Return
END IF

//For x1 = 1 To dw_1.RowCount()
//  mp			  = dw_1.GetItemString(x1,"mp")
//  calidad	  = dw_1.GetItemString(x1,"calidad")
//  existencias = dw_1.GetItemNumber(x1,"stock")
//End For
//
//***
//dw_1.SetFilter("disponible <> 0")											  
//dw_1.Filter()
//***

dw_1.SetRedraw(True)


Dw_detalle.Retrieve(codigo_empresa,&
                    dw_1.GetItemString(dw_1.GetRow(),"mp"),&
                    dw_1.GetItemString(dw_1.GetRow(),"calidad"))
dw_detalle.SetRedraw(True)



end subroutine

public function boolean f_modificacion_art ();
String tipo_unidad,descripcion,mp,mascara

mp = uo_mp.em_codigo.text
Select descripcion,tipo_unidad
Into   :descripcion,:tipo_unidad
From   venmprima
Where  venmprima.empresa = :codigo_empresa
And    venmprima.codigo  = :mp;

uo_mp.em_campo.text=descripcion
IF Trim(uo_mp.em_campo.text)="" THEN 
 IF Trim(uo_mp.em_codigo.text)<>"" Then uo_mp.em_campo.SetFocus()
 uo_mp.em_campo.text=""
 uo_mp.em_codigo.text=""
 return TRUE
END IF
mascara = f_mascara_unidad(tipo_unidad)
f_mascara_columna(dw_1,"disponible",mascara)
IF Trim(uo_mp.em_codigo.text)<>"" Then f_control()


RETURN TRUE




end function

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_detalle.SetTransObject(sqlca)

devolver = "N"
This.title = " CONSULTA STOCKS POR MATERIAS PRIMAS "
istr_parametros = Message.PowerObjectParm


f_activar_campo(uo_mp.em_campo)
end event

on w_con_stock_mp.create
int iCurrent
call super::create
this.st_3=create st_3
this.pb_2=create pb_2
this.uo_mp=create uo_mp
this.dw_1=create dw_1
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.uo_mp
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_detalle
end on

on w_con_stock_mp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.pb_2)
destroy(this.uo_mp)
destroy(this.dw_1)
destroy(this.dw_detalle)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_stock_mp
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_stock_mp
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_stock_mp
integer y = 20
integer width = 2587
integer height = 92
end type

type st_3 from statictext within w_con_stock_mp
integer x = 91
integer y = 160
integer width = 425
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Materia Prima"
boolean focusrectangle = false
end type

type pb_2 from upb_salir within w_con_stock_mp
integer x = 2747
integer y = 16
integer width = 114
integer height = 104
integer taborder = 0
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type uo_mp from u_em_campo_2 within w_con_stock_mp
integer x = 549
integer y = 152
integer width = 1893
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;dw_detalle.reset()
f_modificacion_art() 
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de materias primas"
ue_datawindow = "dw_ayuda_venmprima"
ue_filtro     = ""
ante_articulo = uo_mp.em_codigo.text
end event

on uo_mp.destroy
call u_em_campo_2::destroy
end on

type dw_1 from u_datawindow_consultas within w_con_stock_mp
integer x = 5
integer y = 248
integer width = 905
integer height = 856
integer taborder = 30
string dataobject = "dw_con_stock_mp2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event getfocus;call super::getfocus;//IF dw_1.GetRow() =0 Then Return
//dw_detalle.Visible = TRUE
//dw_detalle.Retrieve(codigo_empresa,&
//                    dw_1.GetItemString(dw_1.GetRow(),"referencia"),&
//                    dw_1.GetItemString(dw_1.GetRow(),"codigo_tipo_pallet"))
//
//if dw_1.Rowcount()<>0 then 
//   dw_1.SetRow(1)
//   dw_1.SelectRow(1,true)
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;IF dw_1.GetRow() =0 Then Return
dw_detalle.Visible = TRUE
dw_detalle.Retrieve(codigo_empresa,&
                    dw_1.GetItemString(dw_1.GetRow(),"mp"),&
                    dw_1.GetItemString(dw_1.GetRow(),"calidad"))

end event

event key;call super::key;//contro = "S"
end event

type dw_detalle from datawindow within w_con_stock_mp
integer x = 1097
integer y = 332
integer width = 1321
integer height = 564
boolean bringtotop = true
string dataobject = "dw_con_stock_mp3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;if row=0 then return
str_parametros valores
CHOOSE CASE f_objeto_datawindow(This) 
   CASE 'marca'
    IF dw_detalle.getitemString(row,"marca") = "*" Then
      valores.s_argumentos[1]=dw_detalle.getitemString(row,"referencia")
      valores.s_argumentos[2]=dw_detalle.getitemString(row,"tipo_pallet")
      OpenWithParm(w_observaciones_almlinubica,valores)
    END IF
END CHOOSE

end event


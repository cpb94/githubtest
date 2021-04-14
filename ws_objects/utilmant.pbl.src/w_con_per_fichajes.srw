$PBExportHeader$w_con_per_fichajes.srw
forward
global type w_con_per_fichajes from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_per_fichajes
end type
type dw_1 from u_datawindow_consultas within w_con_per_fichajes
end type
type em_fechadesde from u_em_campo within w_con_per_fichajes
end type
type st_7 from statictext within w_con_per_fichajes
end type
type cb_2 from commandbutton within w_con_per_fichajes
end type
type pb_imprimir_preli from upb_imprimir within w_con_per_fichajes
end type
type em_fechahasta from u_em_campo within w_con_per_fichajes
end type
type sle_nombre from singlelineedit within w_con_per_fichajes
end type
type st_2 from statictext within w_con_per_fichajes
end type
type sle_apellido1 from singlelineedit within w_con_per_fichajes
end type
type st_3 from statictext within w_con_per_fichajes
end type
type st_1 from statictext within w_con_per_fichajes
end type
type uo_grupo from u_em_campo_2 within w_con_per_fichajes
end type
type st_12 from statictext within w_con_per_fichajes
end type
type uo_subgrupo from u_em_campo_2 within w_con_per_fichajes
end type
type st_5 from statictext within w_con_per_fichajes
end type
type sle_tarjeta from singlelineedit within w_con_per_fichajes
end type
type st_4 from statictext within w_con_per_fichajes
end type
end forward

global type w_con_per_fichajes from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3904
integer height = 2516
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
em_fechahasta em_fechahasta
sle_nombre sle_nombre
st_2 st_2
sle_apellido1 sle_apellido1
st_3 st_3
st_1 st_1
uo_grupo uo_grupo
st_12 st_12
uo_subgrupo uo_subgrupo
st_5 st_5
sle_tarjeta sle_tarjeta
st_4 st_4
end type
global w_con_per_fichajes w_con_per_fichajes

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
end variables

forward prototypes
public subroutine f_control ()
public function boolean f_modificacion_art ()
end prototypes

public subroutine f_control ();String  referencia,tipo_pallet,nombre_calidad,nombre_tipo_pallet,calidad
dec{2}  existencias,disponible,preparado,reservado
Integer tono,calibre,x1

//dw_1.SetRedraw(False)
//dw_fabricar.SetRedraw(False)
//dw_recibir.SetRedraw(False)
//dw_detalle.SetRedraw(False)
//
//IF dw_1.Retrieve(codigo_empresa,uo_articulo.em_codigo.text) = 0 Then 
//	dw_fabricar.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
//	dw_recibir.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
//	dw_detalle.reset()
//	dw_1.SetRedraw(True)
//	dw_fabricar.SetRedraw(True)
//	dw_recibir.SetRedraw(True)											  
//	Return
//END IF
//
//For x1 = 1 To dw_1.RowCount()
//  referencia  = dw_1.GetItemString(x1,"referencia")
//  tipo_pallet = dw_1.GetItemString(x1,"tipo_pallet")
//  existencias = dw_1.GetItemNumber(x1,"stock")
//  calidad=f_referencia_codcalidad(referencia)
//  nombre_calidad    =f_nombre_calidad_abr(codigo_empresa,calidad)
//  nombre_tipo_pallet=f_nombre_pallet_abr(codigo_empresa,tipo_pallet)
//  tono=f_referencia_tono(referencia)
//  calibre=f_referencia_calibre(referencia)
//  dw_1.SetItem(x1,"codigo_calidad",calidad)
//  dw_1.SetItem(x1,"calidad",nombre_calidad)
//  dw_1.SetItem(x1,"tono",tono)
//  dw_1.SetItem(x1,"calibre",calibre)
//  dw_1.SetItem(x1,"nombre_tipo_pallet",nombre_tipo_pallet)
//  reservado  = f_reservado_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet)
//  preparado  = f_preparado_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet)
//  disponible = existencias - reservado - preparado
//  dw_1.SetItem(x1,"disponible",disponible)
//  dw_1.SetItem(x1,"reservado",reservado)
//  dw_1.SetItem(x1,"preparado",preparado)
//  IF f_observ_almlinubica(codigo_empresa,referencia,tipo_pallet)  Then
//   dw_1.SetItem(x1,"valor","*")
//	END IF
//End For
//dw_1.SetRedraw(True)
//dw_fabricar.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
//dw_recibir.Retrieve(codigo_empresa,uo_articulo.em_codigo.text)
//
//Dw_detalle.Retrieve(codigo_empresa,&
//                    dw_1.GetItemString(dw_1.GetRow(),"referencia"),&
//                    dw_1.GetItemString(dw_1.GetRow(),"tipo_pallet"))
//dw_fabricar.SetRedraw(True)
//dw_recibir.SetRedraw(True)											  
//dw_detalle.SetRedraw(True)
//											  
//
//
end subroutine

public function boolean f_modificacion_art ();
String formato,tipo_unidad,descripcion,articulo,mascara
Dec{4}  metros_caja,piezascaja,peso
//articulo = uo_articulo.em_codigo.text
//Select descripcion,formato,unidad,metroscaja,piezascaja,pesopieza
//Into   :descripcion,:formato,:tipo_unidad,:metros_caja,:piezascaja,:peso
//From   articulos
//Where  articulos.empresa = :codigo_empresa
//And    articulos.codigo  = :articulo;
//
//uo_articulo.em_campo.text=descripcion
//IF Trim(uo_articulo.em_campo.text)="" THEN 
// IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
// uo_articulo.em_campo.text=""
// uo_articulo.em_codigo.text=""
// return TRUE
//END IF
//mascara = f_mascara_unidad(tipo_unidad)
//f_mascara_columna(dw_1,"disponible",mascara)
//f_mascara_columna(dw_1,"preparado",mascara)
//f_mascara_columna(dw_1,"reservado",mascara)
//IF Trim(uo_articulo.em_codigo.text)<>"" Then f_control()
//st_tipo_unidad.text  = f_nombre_unidad(tipo_unidad)
//st_tipo_formato.text = f_nombre_formato_abr(codigo_empresa,formato)
//st_metros.text       = string(metros_caja,"###,##0.00")
//st_piezas.text       = string(piezascaja,"###,##0")
//st_peso.text         = string(peso,"###.#00")
Return TRUE

end function

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 0
		MESSAGEBOX("Atención: No seas Cotilla !!! ",nombre_usuario+", No tienes Acceso a este programa")
		close(this)
		return
end choose


dw_1.SetTransObject(sqlca)

This.title = " CONSULTA DE FICHAJES "

em_fechadesde.text=String(DateTime(Today()),"dd-mm-yy")
em_fechahasta.text=String(DateTime(Today()),"dd-mm-yy")

f_activar_campo(em_fechadesde)
end event

on w_con_per_fichajes.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.em_fechahasta=create em_fechahasta
this.sle_nombre=create sle_nombre
this.st_2=create st_2
this.sle_apellido1=create sle_apellido1
this.st_3=create st_3
this.st_1=create st_1
this.uo_grupo=create uo_grupo
this.st_12=create st_12
this.uo_subgrupo=create uo_subgrupo
this.st_5=create st_5
this.sle_tarjeta=create sle_tarjeta
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.em_fechahasta
this.Control[iCurrent+8]=this.sle_nombre
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.sle_apellido1
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.uo_grupo
this.Control[iCurrent+14]=this.st_12
this.Control[iCurrent+15]=this.uo_subgrupo
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.sle_tarjeta
this.Control[iCurrent+18]=this.st_4
end on

on w_con_per_fichajes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.em_fechahasta)
destroy(this.sle_nombre)
destroy(this.st_2)
destroy(this.sle_apellido1)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.uo_grupo)
destroy(this.st_12)
destroy(this.uo_subgrupo)
destroy(this.st_5)
destroy(this.sle_tarjeta)
destroy(this.st_4)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_per_fichajes
integer taborder = 60
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_per_fichajes
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_per_fichajes
integer y = 20
integer width = 3415
integer height = 92
end type

type pb_2 from upb_salir within w_con_per_fichajes
integer x = 3744
integer y = 20
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

type dw_1 from u_datawindow_consultas within w_con_per_fichajes
integer x = 14
integer y = 356
integer width = 3831
integer height = 1876
integer taborder = 0
string dataobject = "dw_con_per_fichajes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type em_fechadesde from u_em_campo within w_con_per_fichajes
integer x = 233
integer y = 148
integer width = 293
integer height = 80
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_7 from statictext within w_con_per_fichajes
integer x = 14
integer y = 148
integer width = 229
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_per_fichajes
event clicked pbm_bnclicked
integer x = 3360
integer y = 148
integer width = 361
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;string nombre, apellido1, grupo, subgrupo, tarjeta

datetime fechai,fechaf


fechai       = DateTime(Date(em_fechadesde.text))
fechaf       = DateTime(Date(em_fechahasta.text))
dw_1.Reset()
dw_1.SetRedraw(FALSE)

if sle_nombre.text = '' or isnull (sle_nombre.text) then 
	nombre = '%'
else
	nombre = '%'+upper(sle_nombre.text)+'%'
end if
if sle_apellido1.text = '' or isnull (sle_apellido1.text) then 
	apellido1 = '%'
else
	apellido1 = '%'+upper(sle_apellido1.text)+'%'
end if
if uo_grupo.em_codigo.text = '' or isnull (uo_grupo.em_codigo.text) then 
	grupo = '%'
else
	grupo = uo_grupo.em_codigo.text
end if
if uo_subgrupo.em_codigo.text = '' or isnull (uo_subgrupo.em_codigo.text) then 
	subgrupo = '%'
else
	subgrupo = uo_subgrupo.em_codigo.text
end if

if sle_tarjeta.text = '' or isnull (sle_tarjeta.text) then 
	tarjeta = '%'
else
	tarjeta = upper(sle_tarjeta.text)
end if

dw_1.Retrieve(codigo_empresa,fechai,fechaf, nombre, apellido1, grupo, subgrupo)

dw_1.setfilter("per_empleados_tarjeta like '"+tarjeta+"'")
dw_1.Filter()

//dw_1.GroupCalc()
dw_1.SetRedraw(TRUE)

end event

type pb_imprimir_preli from upb_imprimir within w_con_per_fichajes
event clicked pbm_bnclicked
integer x = 3744
integer y = 140
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;	
f_imprimir_datawindow(dw_1)
//dw_1.GroupCalc()
//dw_1.Print(False)
end event

type em_fechahasta from u_em_campo within w_con_per_fichajes
integer x = 233
integer y = 240
integer width = 293
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type sle_nombre from singlelineedit within w_con_per_fichajes
integer x = 837
integer y = 136
integer width = 539
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_con_per_fichajes
integer x = 553
integer y = 144
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nombre:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_apellido1 from singlelineedit within w_con_per_fichajes
integer x = 1760
integer y = 136
integer width = 539
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_con_per_fichajes
integer x = 1403
integer y = 140
integer width = 347
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "1º Apellido:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_con_per_fichajes
integer x = 14
integer y = 240
integer width = 210
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_grupo from u_em_campo_2 within w_con_per_fichajes
integer x = 832
integer y = 236
integer width = 1038
integer height = 76
integer taborder = 230
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;string descripcion

select descripcion
into :descripcion
from per_grupos
where empresa = :codigo_empresa
and codigo = :uo_grupo.em_codigo.text;

uo_grupo.em_campo.text = descripcion
If Trim(uo_grupo.em_campo.text)="" then
	uo_grupo.em_campo.text=""
	uo_grupo.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Grupos	"
ue_datawindow ="dw_ayuda_per_grupos"
ue_filtro = ""
end event

on uo_grupo.destroy
call u_em_campo_2::destroy
end on

type st_12 from statictext within w_con_per_fichajes
integer x = 567
integer y = 248
integer width = 251
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Grupo:"
alignment alignment = right!
long bordercolor = 15793151
boolean focusrectangle = false
end type

type uo_subgrupo from u_em_campo_2 within w_con_per_fichajes
integer x = 2267
integer y = 236
integer width = 946
integer height = 76
integer taborder = 240
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;string descripcion

select descripcion
into :descripcion
from per_subgrupos
where empresa = :codigo_empresa
and codigo = :uo_subgrupo.em_codigo.text;

uo_subgrupo.em_campo.text = descripcion
If Trim(uo_subgrupo.em_campo.text)="" then
	uo_subgrupo.em_campo.text=""
	uo_subgrupo.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de SubGrupos	"
ue_datawindow ="dw_ayuda_per_subgrupos"
ue_filtro = ""
end event

on uo_subgrupo.destroy
call u_em_campo_2::destroy
end on

type st_5 from statictext within w_con_per_fichajes
integer x = 1961
integer y = 248
integer width = 283
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "SubGrupo:"
alignment alignment = right!
long bordercolor = 15793151
boolean focusrectangle = false
end type

type sle_tarjeta from singlelineedit within w_con_per_fichajes
integer x = 2807
integer y = 136
integer width = 187
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type st_4 from statictext within w_con_per_fichajes
integer x = 2455
integer y = 140
integer width = 343
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
string text = "Tarjeta:"
alignment alignment = right!
boolean focusrectangle = false
end type


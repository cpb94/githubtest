$PBExportHeader$wi_mant_palarticulo.srw
forward
global type wi_mant_palarticulo from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_palarticulo
end type
type st_nombre_articulo from statictext within wi_mant_palarticulo
end type
type sle_articulo from u_em_campo within wi_mant_palarticulo
end type
type st_pallet_nombre from statictext within wi_mant_palarticulo
end type
type dw_pallets_articulos from datawindow within wi_mant_palarticulo
end type
type st_3 from statictext within wi_mant_palarticulo
end type
type sle_caja from u_em_campo within wi_mant_palarticulo
end type
type st_caja_nombre from statictext within wi_mant_palarticulo
end type
type pb_1 from picturebutton within wi_mant_palarticulo
end type
end forward

global type wi_mant_palarticulo from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2373
integer height = 1596
st_almacen st_almacen
st_nombre_articulo st_nombre_articulo
sle_articulo sle_articulo
st_pallet_nombre st_pallet_nombre
dw_pallets_articulos dw_pallets_articulos
st_3 st_3
sle_caja sle_caja
st_caja_nombre st_caja_nombre
pb_1 pb_1
end type
global wi_mant_palarticulo wi_mant_palarticulo

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
dw_1.Retrieve(codigo_empresa,sle_articulo.text,sle_valor.text,sle_caja.text)

dw_pallets_articulos.Retrieve(codigo_empresa,sle_articulo.text, sle_caja.text)


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de pallets por artículo"
istr_parametros.s_listado        = "report_palarticulos"
This.title=istr_parametros.s_titulo_ventana
dw_pallets_articulos.SetTransObject(SQLCA)

f_mascara_columna(dw_1,"alturas","##0")
f_mascara_columna(dw_1,"alto","##0")
f_activar_campo(sle_articulo)
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"articulo",sle_articulo.text)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"caja",sle_caja.text)
dw_1.object.pordefecto[dw_1.getrow()] = 'S'

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_articulo.text))
criterio[2]   =  trim(sle_articulo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "palarticulo"


f_control()
CALL Super::ue_recuperar
end event

on wi_mant_palarticulo.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_articulo=create st_nombre_articulo
this.sle_articulo=create sle_articulo
this.st_pallet_nombre=create st_pallet_nombre
this.dw_pallets_articulos=create dw_pallets_articulos
this.st_3=create st_3
this.sle_caja=create sle_caja
this.st_caja_nombre=create st_caja_nombre
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_articulo
this.Control[iCurrent+3]=this.sle_articulo
this.Control[iCurrent+4]=this.st_pallet_nombre
this.Control[iCurrent+5]=this.dw_pallets_articulos
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_caja
this.Control[iCurrent+8]=this.st_caja_nombre
this.Control[iCurrent+9]=this.pb_1
end on

on wi_mant_palarticulo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_articulo)
destroy(this.sle_articulo)
destroy(this.st_pallet_nombre)
destroy(this.dw_pallets_articulos)
destroy(this.st_3)
destroy(this.sle_caja)
destroy(this.st_caja_nombre)
destroy(this.pb_1)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_articulo.enabled=FALSE
sle_valor.enabled=FALSE
sle_caja.enabled=FALSE
end event

event ue_activa_claves;call super::ue_activa_claves;sle_articulo.enabled=TRUE
sle_valor.enabled=TRUE
sle_caja.enabled=TRUE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_palarticulo
integer x = 338
integer y = 468
integer width = 1623
integer height = 416
string dataobject = "dw_pallets_articulo"
borderstyle borderstyle = stylelowered!
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_palarticulo
integer x = 101
integer y = 348
integer width = 238
integer height = 80
integer textsize = -9
fontcharset fontcharset = ansi!
string text = "Pallet:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_palarticulo
integer x = 1979
integer y = 164
integer width = 352
end type

event cb_insertar::clicked;long num_pedidos

SELECT ISNULL(COUNT(*), 0) 
INTO :num_pedidos 
FROM venliped 
WHERE articulo = :sle_articulo.text 
	AND caja = :sle_caja.text
	AND tipo_pallet = :sle_valor.text
USING SQLCA;

/*
if num_pedidos > 0 /*and (familia = "2" or familia = "3" or familia = "4") */ then
	 MessageBox("¡Atención!", "Existe algún pedido en marcha.~n NO SE PUEDEN CAMBIAR LAS ESPECIFICACIONES ",StopSign!,OK!)
	return
end if
*/

update palarticulo set pordefecto = 'N' 
where empresa = :codigo_empresa
and articulo = :sle_articulo.text
and caja = :sle_caja.text
and codigo <> :sle_valor.text;


call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_palarticulo
integer x = 1984
integer y = 268
integer width = 352
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_palarticulo
integer x = 352
integer y = 348
integer taborder = 30
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

event sle_valor::modificado;call super::modificado;st_pallet_nombre.text=f_nombre_pallet(codigo_empresa,sle_valor.text)
IF Trim(st_pallet_nombre.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
//f_control()
end event

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE PALLETS"
ue_datawindow = "dw_ayuda_pallets"
ue_filtro     = ""
isle_campo    = This

IF trim(sle_articulo.text)= "" THEN
	f_activar_campo(sle_articulo)
	Return	 
End if	

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_palarticulo
integer x = 1984
integer y = 368
integer width = 352
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_palarticulo
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_palarticulo
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_palarticulo
integer x = 9
integer width = 2313
end type

type st_almacen from statictext within wi_mant_palarticulo
integer x = 101
integer y = 164
integer width = 238
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_articulo from statictext within wi_mant_palarticulo
integer x = 846
integer y = 164
integer width = 1106
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 30146300
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type sle_articulo from u_em_campo within wi_mant_palarticulo
integer x = 352
integer y = 164
integer width = 466
integer taborder = 10
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

event getfocus;call super::getfocus;  ue_titulo     = "AYUDA SELECCION DE ARTÍCULOS"
  ue_datawindow = "dw_ayuda_articulos"
  ue_filtro     = ""
  isle_campo    = This
  sle_valor.Text = ""
  
  f_control()
        
  IF istr_parametros.i_nargumentos>1 THEN
 	  sle_articulo.text=istr_parametros.s_argumentos[2]	
     sle_articulo.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(sle_articulo.text)<>"" THEN
          Parent.TriggerEvent("ue_recuperar")
			 f_activar_campo(sle_caja)
			 Return
		else
			 f_activar_campo(sle_caja)
			 Return
     END IF
  END IF







end event

event modificado;call super::modificado;st_nombre_articulo.text=f_nombre_articulo(codigo_empresa,sle_articulo.text)
IF Trim(st_nombre_articulo.text)="" THEN 
 IF Trim(sle_articulo.text)<>"" Then  f_activar_campo(sle_articulo)
 sle_articulo.text=""
END IF
end event

type st_pallet_nombre from statictext within wi_mant_palarticulo
integer x = 626
integer y = 348
integer width = 1330
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 30146300
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type dw_pallets_articulos from datawindow within wi_mant_palarticulo
integer x = 338
integer y = 916
integer width = 1623
integer height = 436
boolean bringtotop = true
string dataobject = "dw_pallets_articulo1"
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

sle_valor.text  = This.GetItemString(Row,"codigo")
sle_valor.TriggerEvent("modificado")

Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)

end event

type st_3 from statictext within wi_mant_palarticulo
integer x = 101
integer y = 256
integer width = 238
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Caja:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_caja from u_em_campo within wi_mant_palarticulo
integer x = 352
integer y = 256
integer width = 338
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event modificado;call super::modificado;st_caja_nombre.text=f_nombre_caja(codigo_empresa,sle_caja.text)
IF Trim(st_caja_nombre.text)="" THEN 
 IF Trim(sle_caja.text)<>"" Then  f_activar_campo(sle_caja)
 sle_valor.text=""
END IF
f_control()
end event

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE CAJAS"
ue_datawindow = "dw_ayuda_almartcajas_sin_pallet"
ue_filtro     = "almartcajas_articulo = '" + sle_articulo.text+ "'"
isle_campo    = This

IF trim(sle_articulo.text)= "" THEN
	f_activar_campo(sle_articulo)
	Return	 
End if	

end event

type st_caja_nombre from statictext within wi_mant_palarticulo
integer x = 818
integer y = 256
integer width = 1134
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 30146300
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type pb_1 from picturebutton within wi_mant_palarticulo
integer x = 709
integer y = 256
integer width = 91
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\carpeta.bmp"
alignment htextalign = right!
end type

event clicked;str_parametros lstr_param

lstr_param.s_titulo_ventana = "Mantenimiento de Cajas por Artículo"
lstr_param.s_argumentos[2]  = sle_articulo.text
lstr_param.i_nargumentos    = 2
OpenWithParm(wi_mant_articulocaja, lstr_param)
end event


$PBExportHeader$w_int_depmovent.srw
forward
global type w_int_depmovent from w_int_con_empresa
end type
type st_12 from statictext within w_int_depmovent
end type
type st_11 from statictext within w_int_depmovent
end type
type st_texto_cantidad from statictext within w_int_depmovent
end type
type st_8 from statictext within w_int_depmovent
end type
type st_7 from statictext within w_int_depmovent
end type
type st_6 from statictext within w_int_depmovent
end type
type st_5 from statictext within w_int_depmovent
end type
type st_4 from statictext within w_int_depmovent
end type
type st_3 from statictext within w_int_depmovent
end type
type st_2 from statictext within w_int_depmovent
end type
type st_1 from statictext within w_int_depmovent
end type
type st_nombre_tipomov from statictext within w_int_depmovent
end type
type st_proveedor_etiqueta from statictext within w_int_depmovent
end type
type st_nombre_cliente from statictext within w_int_depmovent
end type
type pb_1 from upb_salir within w_int_depmovent
end type
type em_fecha from u_em_campo within w_int_depmovent
end type
type sle_tipomov from u_em_campo within w_int_depmovent
end type
type em_tono from u_em_campo within w_int_depmovent
end type
type em_calibre from u_em_campo within w_int_depmovent
end type
type em_t_pallets from u_em_campo within w_int_depmovent
end type
type em_cajas from u_em_campo within w_int_depmovent
end type
type em_t_cajas from u_em_campo within w_int_depmovent
end type
type em_cantidad from u_em_campo within w_int_depmovent
end type
type cb_1 from u_boton within w_int_depmovent
end type
type uo_calidad from u_em_campo_2 within w_int_depmovent
end type
type pb_borrar from upb_papelera within w_int_depmovent
end type
type uo_tipo_pallet from u_em_campo_2 within w_int_depmovent
end type
type uo_articulo from u_em_campo_2 within w_int_depmovent
end type
type sle_cliente from u_em_campo within w_int_depmovent
end type
type uo_caja from u_em_campo_2 within w_int_depmovent
end type
type st_caja from statictext within w_int_depmovent
end type
type dw_3 from datawindow within w_int_depmovent
end type
end forward

global type w_int_depmovent from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 2917
integer height = 1660
string icon = "\bmp\RINO.ICO"
st_12 st_12
st_11 st_11
st_texto_cantidad st_texto_cantidad
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_nombre_tipomov st_nombre_tipomov
st_proveedor_etiqueta st_proveedor_etiqueta
st_nombre_cliente st_nombre_cliente
pb_1 pb_1
em_fecha em_fecha
sle_tipomov sle_tipomov
em_tono em_tono
em_calibre em_calibre
em_t_pallets em_t_pallets
em_cajas em_cajas
em_t_cajas em_t_cajas
em_cantidad em_cantidad
cb_1 cb_1
uo_calidad uo_calidad
pb_borrar pb_borrar
uo_tipo_pallet uo_tipo_pallet
uo_articulo uo_articulo
sle_cliente sle_cliente
uo_caja uo_caja
st_caja st_caja
dw_3 dw_3
end type
global w_int_depmovent w_int_depmovent

type variables
//str_parametros  istr_parametros
   integer contador,v_altura,v_fila,anyo
  decimal{4} v_cantidad
  decimal{4} ante_valor
  String v_almacen,v_zona,cod_sector
  string ante_numdoc
  String situado
  Boolean  control_tono,control_calibre
// Defino la estructura de la tablas a procesar
   str_deplinubica      ubi
   str_depmovhis       mov



end variables

forward prototypes
public subroutine ver_movimientos ()
public subroutine f_control_tono_calibre ()
end prototypes

public subroutine ver_movimientos ();  dw_3.retrieve(codigo_empresa,year(Date(String(em_fecha.text))),sle_cliente.text,sle_tipomov.text)

end subroutine

public subroutine f_control_tono_calibre (); control_tono   =  TRUE
 control_calibre =  TRUE

 IF Not f_control_tono_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_tono   =  FALSE
 	em_tono.text       =  ""
END IF
IF Not f_control_calibre_artcal(codigo_empresa,uo_articulo.em_codigo.text,uo_calidad.em_codigo.text) Then
   control_calibre =  FALSE
   em_calibre.text    =  ""
 END IF  
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Introduccion movimientos entradas almacen (Depositos)"
This.title=istr_parametros.s_titulo_ventana
em_fecha.text=string(today())

dw_3.Settransobject(SQLCA)



end event

on w_int_depmovent.create
int iCurrent
call super::create
this.st_12=create st_12
this.st_11=create st_11
this.st_texto_cantidad=create st_texto_cantidad
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_nombre_tipomov=create st_nombre_tipomov
this.st_proveedor_etiqueta=create st_proveedor_etiqueta
this.st_nombre_cliente=create st_nombre_cliente
this.pb_1=create pb_1
this.em_fecha=create em_fecha
this.sle_tipomov=create sle_tipomov
this.em_tono=create em_tono
this.em_calibre=create em_calibre
this.em_t_pallets=create em_t_pallets
this.em_cajas=create em_cajas
this.em_t_cajas=create em_t_cajas
this.em_cantidad=create em_cantidad
this.cb_1=create cb_1
this.uo_calidad=create uo_calidad
this.pb_borrar=create pb_borrar
this.uo_tipo_pallet=create uo_tipo_pallet
this.uo_articulo=create uo_articulo
this.sle_cliente=create sle_cliente
this.uo_caja=create uo_caja
this.st_caja=create st_caja
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_12
this.Control[iCurrent+2]=this.st_11
this.Control[iCurrent+3]=this.st_texto_cantidad
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.st_7
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_nombre_tipomov
this.Control[iCurrent+13]=this.st_proveedor_etiqueta
this.Control[iCurrent+14]=this.st_nombre_cliente
this.Control[iCurrent+15]=this.pb_1
this.Control[iCurrent+16]=this.em_fecha
this.Control[iCurrent+17]=this.sle_tipomov
this.Control[iCurrent+18]=this.em_tono
this.Control[iCurrent+19]=this.em_calibre
this.Control[iCurrent+20]=this.em_t_pallets
this.Control[iCurrent+21]=this.em_cajas
this.Control[iCurrent+22]=this.em_t_cajas
this.Control[iCurrent+23]=this.em_cantidad
this.Control[iCurrent+24]=this.cb_1
this.Control[iCurrent+25]=this.uo_calidad
this.Control[iCurrent+26]=this.pb_borrar
this.Control[iCurrent+27]=this.uo_tipo_pallet
this.Control[iCurrent+28]=this.uo_articulo
this.Control[iCurrent+29]=this.sle_cliente
this.Control[iCurrent+30]=this.uo_caja
this.Control[iCurrent+31]=this.st_caja
this.Control[iCurrent+32]=this.dw_3
end on

on w_int_depmovent.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_texto_cantidad)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_nombre_tipomov)
destroy(this.st_proveedor_etiqueta)
destroy(this.st_nombre_cliente)
destroy(this.pb_1)
destroy(this.em_fecha)
destroy(this.sle_tipomov)
destroy(this.em_tono)
destroy(this.em_calibre)
destroy(this.em_t_pallets)
destroy(this.em_cajas)
destroy(this.em_t_cajas)
destroy(this.em_cantidad)
destroy(this.cb_1)
destroy(this.uo_calidad)
destroy(this.pb_borrar)
destroy(this.uo_tipo_pallet)
destroy(this.uo_articulo)
destroy(this.sle_cliente)
destroy(this.uo_caja)
destroy(this.st_caja)
destroy(this.dw_3)
end on

event activate;call super::activate;w_int_depmovent = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_depmovent
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_depmovent
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_depmovent
integer width = 2656
integer height = 108
end type

type st_12 from statictext within w_int_depmovent
integer x = 14
integer y = 312
integer width = 293
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tipo Mvto"
boolean focusrectangle = false
end type

type st_11 from statictext within w_int_depmovent
integer x = 50
integer y = 172
integer width = 247
integer height = 84
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_texto_cantidad from statictext within w_int_depmovent
integer x = 2272
integer y = 444
integer width = 384
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_8 from statictext within w_int_depmovent
integer x = 1504
integer y = 444
integer width = 174
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Pal"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_7 from statictext within w_int_depmovent
integer x = 1934
integer y = 444
integer width = 334
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "T.Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_int_depmovent
integer x = 1682
integer y = 444
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_int_depmovent
integer x = 1394
integer y = 444
integer width = 105
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Tp"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_int_depmovent
integer x = 1129
integer y = 444
integer width = 82
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_depmovent
integer x = 919
integer y = 444
integer width = 206
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_depmovent
integer x = 809
integer y = 444
integer width = 114
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_int_depmovent
integer x = 23
integer y = 444
integer width = 786
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_nombre_tipomov from statictext within w_int_depmovent
integer x = 645
integer y = 312
integer width = 896
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_proveedor_etiqueta from statictext within w_int_depmovent
integer x = 672
integer y = 172
integer width = 238
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_cliente from statictext within w_int_depmovent
integer x = 1321
integer y = 164
integer width = 1129
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
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_int_depmovent
integer x = 2702
integer y = 36
integer width = 128
integer height = 108
integer taborder = 0
alignment htextalign = right!
end type

type em_fecha from u_em_campo within w_int_depmovent
integer x = 329
integer y = 172
integer width = 293
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

on modified;call u_em_campo::modified;ver_movimientos()
end on

type sle_tipomov from u_em_campo within w_int_depmovent
integer x = 347
integer y = 308
integer width = 293
integer taborder = 20
end type

event modificado;call super::modificado;st_nombre_tipomov.text=f_nombre_deptipomov(codigo_empresa,sle_tipomov.text)
IF LEN(st_nombre_tipomov.text)=0 THEN 
   IF LEN(sle_tipomov.text)<>0 Then f_activar_campo(sle_tipomov)
   sle_tipomov.text="" 
   Return
END IF
IF f_interno_devtipomov(codigo_empresa,sle_tipomov.text)= "S" Or&
    f_codigo_real_deptipomov(codigo_empresa,sle_tipomov.text)<> "E"  Then
 sle_tipomov.text="" 
 st_nombre_tipomov.text = ""
END IF
ver_movimientos()


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de tipos de movimientos"
ue_datawindow = "dw_ayuda_deptipomov_entradas"
ue_filtro     = "interno = 'N'"
end event

type em_tono from u_em_campo within w_int_depmovent
integer x = 919
integer y = 516
integer width = 206
integer taborder = 60
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
string mask = "!!!!"
end type

event getfocus;call super::getfocus;f_control_tono_calibre()
end event

event losefocus;call super::losefocus;f_control_tono_calibre()
end event

type em_calibre from u_em_campo within w_int_depmovent
integer x = 1125
integer y = 516
integer width = 82
integer taborder = 70
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "#"
end type

event getfocus;call super::getfocus;f_control_tono_calibre()
end event

event losefocus;call super::losefocus;f_control_tono_calibre()
end event

type em_t_pallets from u_em_campo within w_int_depmovent
integer x = 1499
integer y = 516
integer width = 174
integer taborder = 100
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;situado= "PALLET"
end event

event modificado;call super::modificado;string cadena
long posi_aux, posi

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
								  uo_caja.em_codigo.text,&
                          integer(em_t_pallets.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
							 
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_t_pallets.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_t_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if
							 
//em_t_pallets.text    =Mid(cadena,1,6)
//em_cajas.text        =Mid(cadena,7,6)
//em_t_cajas.text      =Mid(cadena,13,6)
//em_cantidad.text     =Mid(cadena,19,9)


end event

type em_cajas from u_em_campo within w_int_depmovent
integer x = 1678
integer y = 516
integer width = 247
integer taborder = 110
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;situado= "CAJAS"
end event

event modificado;call super::modificado;string cadena
long posi_aux, posi

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          uo_tipo_pallet.em_codigo.text,&
                          uo_caja.em_codigo.text,&
								  integer(em_t_pallets.text),&
                           integer(em_cajas.text),&
                           Dec(em_cantidad.text))
                      
							 
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_t_pallets.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_t_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if
							 
//em_t_pallets.text  =Mid(cadena,1,6)
//em_cajas.text      =Mid(cadena,7,6)
//em_t_cajas.text    =Mid(cadena,13,6)
//em_cantidad.text     =Mid(cadena,19,9)

end event

type em_t_cajas from u_em_campo within w_int_depmovent
integer x = 1929
integer y = 516
integer width = 334
integer taborder = 0
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
boolean displayonly = true
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event getfocus;call super::getfocus;situado= "TOTAL_CAJAS"
end event

type em_cantidad from u_em_campo within w_int_depmovent
integer x = 2267
integer y = 516
integer width = 384
integer taborder = 120
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event getfocus;call super::getfocus;ante_valor= Dec(em_cantidad.text)
situado= "CANTIDAD"
end event

event modificado;call super::modificado;string cadena
long posi_aux, posi

If ante_valor<>Dec(em_cantidad.text) THEN
 em_cajas.text=""
 em_t_cajas.text=""
 em_t_pallets.text=""
END  IF

 cadena = f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                            uo_tipo_pallet.em_codigo.text,&
                            uo_caja.em_codigo.text,&
									 integer(em_t_pallets.text),&
                            integer(em_cajas.text),&
                            Dec(em_cantidad.text))
									 
									 
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_t_pallets.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_t_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if
									 
                       
// em_t_pallets.text  =Mid(cadena,1,6)
// em_cajas.text      =Mid(cadena,7,6)
// em_t_cajas.text    =Mid(cadena,13,6)
// em_cantidad.text   =Mid(cadena,19,9)
//
end event

type cb_1 from u_boton within w_int_depmovent
integer x = 2688
integer y = 456
integer width = 151
integer height = 128
integer taborder = 130
string text = "&OK"
end type

event clicked;//CONTROLES DE VALORES
Date  fecha
string mensaje
// piezas por conjunto
Dec{2} var_conjunto,longitudes,numero,cur_linea

IF trim(em_fecha.text)="00-00-00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_fecha.SetFocus()
   RETURN
END IF


IF trim(sle_tipomov.text)=""  or IsNull(sle_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
   RETURN
END IF


st_nombre_tipomov.text=f_nombre_deptipomov(codigo_empresa,sle_tipomov.text)
IF trim(st_nombre_tipomov.text)="" or IsNull(st_nombre_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento no existe"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
   RETURN
END IF

  st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
  IF trim(st_nombre_cliente.text)="" or IsNull(st_nombre_cliente.text) THEN
   mensaje="El cliente no existe."
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_cliente.Setfocus()
   RETURN
 END IF




IF trim(uo_articulo.em_campo.text)="" THEN
   mensaje="Introduzca el articulo"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_articulo.em_campo.Setfocus()
   RETURN
END IF

 IF trim(uo_calidad.em_campo.text)="" THEN
   mensaje="Introduzca la calidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   uo_calidad.em_campo.Setfocus()
   RETURN
END IF
	
 IF control_tono=TRUE Then
  IF trim(em_tono.text)="" THEN
   mensaje="Introduzca el tono"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_tono.SetFocus()
   RETURN
  END IF
 END IF

 IF control_calibre=TRUE Then
  IF trim(em_calibre.text)="" THEN
   mensaje="Introduzca el calibre"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_calibre.SetFocus()
   RETURN
  END IF
 END IF

 IF trim(uo_tipo_pallet.em_campo.text)="" THEN
   mensaje="Introduzca el tipo de pallet"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   uo_tipo_pallet.Setfocus()
   RETURN
 END IF

string  codigo_articulo,codigo_pallet,codigo_formato

codigo_pallet   = uo_tipo_pallet.em_codigo.text
codigo_articulo = uo_articulo.em_codigo.text

SELECT formato,conjunto  
INTO   :codigo_formato,:var_conjunto  
FROM   articulos  
WHERE  (articulos.empresa = :codigo_empresa ) AND  
	    (articulos.codigo  = :codigo_articulo )   ;



  

//  SELECT palformato.codigo INTO :codigo_pallet  FROM palformato  
//   WHERE palformato.empresa   = :codigo_empresa 
//	AND   palformato.formato   = :codigo_formato
//	AND   palformato.codigo    = :codigo_pallet  USING SQLCA;
// IF SQLCA.SQLCode<>0 THEN
//   mensaje="No Existe el Pallet al formato"
//   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
//   uo_tipo_pallet.em_campo.SetFocus()
//   Return
//END  IF

IF trim(em_cantidad.text)="" THEN
   mensaje="Introduzca nº total de cantidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_cantidad.SetFocus()
   RETURN
END IF

string codigo_real
String codigo_tipomov
codigo_tipomov=sle_tipomov.text

SELECT deptipomov.codigo_real 
INTO   :codigo_real 
FROM   deptipomov  
WHERE  deptipomov.empresa = :codigo_empresa 
AND    deptipomov.tipomov = :codigo_tipomov 
USING  SQLCA;

IF codigo_real<>"E" THEN
   MessageBox("Tipo de Movimiento no valido","Solo se permiten movimiento de entradas ",Exclamation!, OK!,1)
   sle_tipomov.text=""
   sle_tipomov.Setfocus()
   Return	
END IF

IF cod_sector = "S" Then
 String codigo_calidad
 codigo_calidad= uo_calidad.em_codigo.text

 
	SELECT almartcal.calidad 
	INTO   :codigo_calidad 
	FROM   almartcal  
	WHERE  almartcal.empresa   = :codigo_empresa 
	AND    almartcal.articulo  = :codigo_articulo 
	AND    almartcal.calidad   = :codigo_calidad
	USING  SQLCA;
	
   IF SQLCA.SQLCode<>0 THEN
	  MessageBox("Calidad no  valida","Esta calidad no esta definida para el articulo",Exclamation!, OK!,1)
     uo_calidad.em_campo.text        = ""
     uo_calidad.em_codigo.text = ""
     uo_calidad.em_campo.Setfocus()
     Return
   END IF
END IF

// Control piezas por conjunto
IF var_conjunto<> 0 And Not IsNULL(var_conjunto) Then
 IF (Dec(String(Dec(em_cantidad.text)/var_conjunto,"##########")) * var_conjunto) <> Dec(em_cantidad.text) Then
  MessageBox("Cantidad no valida","Esta articulo va por conjuntos la cantidad a de ser multiplo de: " + String(var_conjunto),Exclamation!, OK!,1)
  f_activar_campo(em_cantidad)
  return
 END IF
END IF

string v_referencia
v_referencia = f_componer_ref(uo_articulo.em_codigo.text,&
                            uo_calidad.em_codigo.text,Trim(em_tono.text),Integer(em_calibre.text))



IF f_deposito_cliente_articulo(codigo_empresa,sle_cliente.text,uo_articulo.em_codigo.text, uo_calidad.em_codigo.text)= "N" Then
	 f_mensaje("Error en introduccion Datos","Este articulo no pertenece a deposito")
	 f_activar_campo(uo_articulo.em_campo)
	 Return
END IF


////---------------------------
//// Grabar la entrada
////---------------------------


// Contador de movimiento y orden de lineas de  ubicacion
   integer contador_nummov,contador_orden 

// Valor de controles funcionamiento
   integer bien
//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
v_almacen = f_depalmacen_cliente(codigo_empresa,sle_cliente.text)
IF IsNull(v_almacen) or Trim(v_almacen)= "" Then
	f_mensaje("Error de datos"," Este cliente no tiene almacen de deposito asignado")
	Return
END IF
 mov.usuario       = nombre_usuario
 ubi.empresa       = codigo_empresa
 ubi.almacen       = v_almacen
 ubi.articulo      = uo_articulo.em_codigo.text
 ubi.calidad       = uo_calidad.em_codigo.text
 ubi.tonochar      = Trim(em_tono.text)
 ubi.calibre       = Integer(em_calibre.text)
 ubi.f_alta        = DateTime(Today(),now())
 ubi.tipo_pallet   = uo_tipo_pallet.em_codigo.text
 ubi.caja          = uo_caja.em_codigo.text
 
  SELECT articulos.empresa,articulos.codigo,articulos.familia,   
         articulos.formato,articulos.modelo,articulos.unidad

    INTO :ubi.empresa,:ubi.articulo,:ubi.familia,:ubi.formato,   
         :ubi.modelo,:ubi.tipo_unidad     FROM articulos  
   WHERE (articulos.empresa= :ubi.empresa ) AND  
         (articulos.codigo = :ubi.articulo )   
ORDER BY articulos.empresa ASC,articulos.codigo ASC  USING SQLCA ;
IF SQLCA.SQLCode<>0 THEN bien=1
 ubi.referencia   = f_componer_ref(ubi.articulo,&
                                      ubi.calidad,&
                                      ubi.tonochar,ubi.calibre)


ubi.cliente    =  sle_cliente.text
ubi.f_alta     =  Datetime(today(),now())
// Valor movimiento historico
mov.empresa    =  ubi.empresa
mov.almacen    =  ubi.almacen
mov.articulo   =  ubi.articulo
mov.familia    =  ubi.familia
mov.formato    =  ubi.formato
mov.modelo     =  ubi.modelo
mov.calidad    =  ubi.calidad
mov.tonochar   =  ubi.tonochar
mov.calibre    =  ubi.calibre
mov.tipo_unidad=  ubi.tipo_unidad
mov.tipo_pallet=  ubi.tipo_pallet
mov.caja       =  ubi.caja
mov.referencia =  ubi.referencia
mov.f_alta     =  DateTime(Today(),now())
fecha          =  Date(String(em_fecha.text))
mov.anyo       =  year(fecha)
mov.fechmov    = DateTime(fecha)
mov.tipomov    = sle_tipomov.text
mov.cantidade  = Dec(em_cantidad.text)
mov.cantidads  = 0
mov.precio     = 0
mov.codtercero = sle_cliente.text
mov.numdoc        = ""
mov.situacion     = "N"
mov.observaciones = ""
SetNull(mov.punteado)
mov.antexist      =0
mov.tipo          = "C"


 // Variable utilizada para montaje observaciones en lineas de ubicacion
  String var_observaciones
//-------------------------------------------------------------------
 titulo        =  Parent.title
 longitudes      =  len(trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20-longitudes)
 anyo          =  Year(Date(em_fecha.text))
 longitudes      =  len(trim(string(anyo)))
 criterio[2]   =  trim(string(anyo))+space(20-longitudes)
 longitudes      =  len(trim(v_almacen))
 criterio[3]   =  trim(v_almacen)+space(20-longitudes)
 seleccion     =  criterio[1]+criterio[2]+criterio[3]
 tabla         =  "decoparam"
 IF NOT f_bloquear(tabla,seleccion,titulo) THEN
  COMMIT Using SQLCA; //Solucion nivel insolacion
  contador_nummov= f_depparam_nummov(codigo_empresa,Year(Date(em_fecha.text)))
  mov.nummov     = contador_nummov
     ubi.existencias  = Dec(em_cantidad.text)
       Select Count(*)
		 Into   :numero
		 From   deplinubica  
       WHERE  deplinubica.empresa         = :ubi.empresa 
		 ANd    deplinubica.almacen         = :ubi.almacen
		 AND    deplinubica.referencia      = :ubi.referencia
		 AND    deplinubica.tipo_pallet     = :ubi.tipo_pallet
 		 AND    deplinubica.caja            = :ubi.caja USING SQLCA;
		 IF IsNull(numero) Then numero = 0
		 IF numero > 1 Then f_mensaje("Error","lineas duplicadas")
     IF numero <> 0 Then
     UPDATE deplinubica  
       SET existencias   = deplinubica.existencias + :ubi.existencias,   
       f_alta            = :ubi.f_alta
       WHERE  deplinubica.empresa     = :ubi.empresa 
		 ANd    deplinubica.almacen     = :ubi.almacen
		 AND    deplinubica.referencia  = :ubi.referencia
		 AND    deplinubica.tipo_pallet = :ubi.tipo_pallet 
 		 AND    deplinubica.caja        = :ubi.caja USING SQLCA;
       IF SQLCA.SQLCode<>0 THEN  bien=1
	ELSE
		SELECT  max(deplinubica.linea)  
		INTO    :cur_linea  
		FROM    deplinubica  
		WHERE   deplinubica.empresa = :ubi.empresa
		AND     deplinubica.almacen = :ubi.almacen;
		IF IsNull(cur_linea) or trim(string(cur_linea))="" THEN
			cur_linea = 0 
		END IF
		cur_linea = cur_linea+1
		ubi.linea = cur_linea
		IF NOT f_insert_deplinubica(ubi) Then  bien=1
END IF
//-----------------------Fin Grabación Lineas de Ubicacion--------------
// el contador incrementa uno para cada linea
     contador_orden = contador_orden + 1
 // Grabar el movimiento en el historico por el total de existencias
   IF NOT f_insert_depmovhis(mov) Then
      MessageBox("Error en proceso","Grabando depmovhis",Exclamation!, OK!,1)
      bien=1
   END IF
   IF NOT f_actualiza_depnummov(mov.empresa,Year(Date(em_fecha.text)),mov.nummov) THEN
      bien=1
   END IF

  CHOOSE CASE bien
	CASE 1
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	CASE 0
     COMMIT USING SQLCA;
   CASE ELSE
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
  END CHOOSE

 f_desbloquear(tabla,seleccion,titulo)
 COMMIT using sqlca;

ELSE
 pb_1.enabled=TRUE
 Return
 
END IF
pb_1.enabled=TRUE

ver_movimientos()
uo_articulo.em_codigo.text    = ""
uo_articulo.em_campo.text     = ""
uo_calidad.em_codigo.text     = ""
uo_calidad.em_campo.text      = ""
uo_tipo_pallet.em_codigo.text = ""
uo_tipo_pallet.em_campo.text  = ""
uo_caja.em_codigo.text        = ""
uo_caja.em_campo.text         = ""
em_cajas.text                 = ""
em_t_cajas.text               = ""
em_t_pallets.text             = ""
em_tono.text                  = ""
em_calibre.text               = ""
em_cantidad.text              = ""
f_activar_campo(uo_articulo.em_campo)


end event

type uo_calidad from u_em_campo_2 within w_int_depmovent
integer x = 800
integer y = 516
integer width = 114
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;
uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text) <> "" Then
	uo_calidad.em_campo.SetFocus()
END IF
 uo_calidad.em_campo.text  = ""
 uo_calidad.em_codigo.text = ""
END IF
f_control_tono_calibre()


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""

end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type pb_borrar from upb_papelera within w_int_depmovent
boolean visible = false
integer x = 2734
integer y = 628
integer width = 119
integer height = 100
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;IF dw_3.getrow()=0 THEN
   pb_borrar.visible=FALSE
   Return
END IF
Integer bien = 0
integer opcion,xlinea
opcion=MessageBox("Proceso de borrado de datos","¿Borrar la Salida seleccionada?",question!, YesNo!,2)
IF opcion=2 THEN  Return

string  v_cliente
Dec   cur_existencias
bien=0
//-----------------------------//
// Valores movimiento a anular //
//-----------------------------//
  mov.empresa     =  dw_3.GetItemString(dw_3.getrow(),"empresa")
  mov.anyo        =  dw_3.GetItemNumber(dw_3.getrow(),"anyo")
  mov.almacen     =  dw_3.GetItemString(dw_3.getrow(),"almacen")
  mov.referencia  =  dw_3.GetItemString(dw_3.getrow(),"referencia")
  mov.tipo_pallet =  dw_3.GetItemString(dw_3.getrow(),"tipo_pallet")
  mov.nummov      =  dw_3.GetItemNumber(dw_3.getrow(),"nummov")
  mov.articulo    =  dw_3.GetItemString(dw_3.getrow(),"articulo")
  mov.familia     =  dw_3.GetItemString(dw_3.getrow(),"familia")
  mov.formato     =  dw_3.GetItemString(dw_3.getrow(),"formato")
  mov.modelo      =  dw_3.GetItemString(dw_3.getrow(),"modelo")
  mov.calidad     =  dw_3.GetItemString(dw_3.getrow(),"calidad")
  mov.tono        =  dw_3.GetItemNumber(dw_3.getrow(),"tono")
  mov.calibre     =  dw_3.GetItemNumber(dw_3.getrow(),"calibre")
  v_cliente       = sle_cliente.text
  mov.tipo_unidad =  dw_3.GetItemString(dw_3.getrow(),"tipo_unidad")
  mov.f_alta      = DateTime(Today(),Now())

  IF Not f_anular_depnummov(mov.empresa,mov.almacen,mov.anyo,mov.nummov) Then bien = 1
  v_cantidad      =  dw_3.GetItemNumber(dw_3.getrow(),"cantidade")
  
  	 Select deplinubica.existencias Into :cur_existencias From deplinubica
	 Where  deplinubica.empresa     = :mov.empresa
	 And    deplinubica.almacen     = :mov.almacen 
	 And    deplinubica.referencia  = :mov.referencia
	 And    deplinubica.tipo_pallet = :mov.tipo_pallet;
	 IF SQLCA.SQLCODE = 0 Then
		IF cur_existencias = v_cantidad Then
			Delete from deplinubica
				Where  deplinubica.empresa     = :mov.empresa
			   And    deplinubica.almacen     = :mov.almacen 
				And    deplinubica.referencia  = :mov.referencia
				And    deplinubica.tipo_pallet = :mov.tipo_pallet;
		ELSE
			IF cur_existencias < v_cantidad Then
				bien = 1
			ELSE
				Update deplinubica
				Set    deplinubica.existencias = deplinubica.existencias - :v_cantidad
				Where  deplinubica.empresa     = :mov.empresa
			   And    deplinubica.almacen     = :mov.almacen 
				And    deplinubica.referencia  = :mov.referencia
				And    deplinubica.tipo_pallet = :mov.tipo_pallet;
			END IF
		END IF
	ELSE
		f_mensaje("Error en proceso","Error al selecionar existencias" )	
		bien = 1
   END IF

  
  IF bien = 0 Then
	COMMIT;
  ELSE
	ROLLBACK;
	f_mensaje("Error en datos","La operacion no se actualiza")
  END IF



ver_movimientos()
uo_articulo.em_codigo.text    = ""
uo_articulo.em_campo.text     = ""
uo_calidad.em_codigo.text     = ""
uo_calidad.em_campo.text      = ""
uo_tipo_pallet.em_codigo.text = ""
uo_tipo_pallet.em_campo.text  = ""
em_cajas.text = ""
em_t_cajas.text = ""
em_t_pallets.text = ""
em_tono.text = ""
em_calibre.text = ""
em_cantidad.text = ""
f_activar_campo(uo_articulo.em_campo)

end event

type uo_tipo_pallet from u_em_campo_2 within w_int_depmovent
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1390
integer y = 516
integer width = 105
integer taborder = 90
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_tipo_pallet.em_campo.text=f_nombre_palarticulocaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_tipo_pallet.em_codigo.text,uo_caja.em_codigo.text)

IF Trim(uo_tipo_pallet.em_campo.text)=""  or IsNull(uo_tipo_pallet.em_campo.text)THEN 
 IF Trim(uo_tipo_pallet.em_codigo.text)<>"" Then 
   uo_tipo_pallet.em_campo.SetFocus()
 END IF
 uo_tipo_pallet.em_campo.text=""
 uo_tipo_pallet.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_palarticulo_abr"
ue_filtro     = "(palarticulo_articulo = '" + uo_articulo.em_codigo.text+ "') and "+&
                "(palarticulo_caja = '" + uo_caja.em_codigo.text + "')" 


end event

on uo_tipo_pallet.destroy
call u_em_campo_2::destroy
end on

type uo_articulo from u_em_campo_2 within w_int_depmovent
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 18
integer y = 516
integer width = 782
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_tipo_unidad,var_cliente
uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then 
	uo_articulo.em_campo.SetFocus()
END IF
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
 Return
END IF




 // Selecciono abreviado del la unidad del articulo
  string  codigo_articulo,texto_unidad,cod_familia

  codigo_articulo = uo_articulo.em_codigo.text
  mov.articulo    = codigo_articulo
  SELECT articulos.familia,articulos.unidad
    INTO :cod_familia,:var_tipo_unidad
    FROM articulos  
   WHERE (articulos.empresa = :codigo_empresa) AND  
         (articulos.codigo  = :codigo_articulo);


// Selecciono si la familia tiene tono y calibre
  string cod_tono,cod_calibre

  SELECT familias.empresa,familias.codigo,familias.tono,familias.calibre ,
         familias.sector
    INTO :mov.empresa,:mov.familia,:cod_tono,:cod_calibre,:cod_sector  
    FROM familias  
   WHERE (familias.empresa = :codigo_empresa ) AND  
         (familias.codigo  = :cod_familia )   ;




st_texto_cantidad.text=f_nombre_unidad(var_tipo_unidad)
em_cantidad.Setmask(DecimalMask!,f_mascara_unidad(var_tipo_unidad))

IF cod_sector = "S" THEN
 em_cajas.enabled       = TRUE
 em_calibre.enabled     = TRUE
 em_t_cajas.enabled     = TRUE
 em_t_pallets.enabled   = TRUE
 em_tono.enabled        = TRUE
 uo_calidad.enabled     = TRUE
 uo_tipo_pallet.enabled = TRUE
 st_1.enabled           = TRUE
 st_2.enabled           = TRUE
 st_3.enabled           = TRUE
 st_4.enabled           = TRUE
 st_5.enabled           = TRUE
 st_6.enabled           = TRUE
 st_7.enabled           = TRUE
 st_8.enabled           = TRUE
 f_control_tono_calibre()
// f_activar_campo(uo_calidad.em_campo)
ELSE
 em_cajas.enabled       = FALSE
 em_calibre.enabled     = FALSE
 em_t_cajas.enabled     = FALSE
 em_t_pallets.enabled   = FALSE
 em_tono.enabled        = FALSE
 uo_calidad.enabled     = FALSE
 uo_tipo_pallet.enabled = FALSE
 st_1.enabled           = FALSE
 st_2.enabled           = FALSE
 st_3.enabled           = FALSE
 st_4.enabled           = FALSE
 st_5.enabled           = FALSE
 st_6.enabled           = FALSE
 st_7.enabled           = FALSE
 st_8.enabled           = FALSE
 em_cajas.text          = ""
 em_calibre.text        = ""
 em_t_cajas.text        = "0"
 em_t_pallets.text      = "0"
 em_tono.text           = ""
 uo_calidad.em_codigo.text     = ""
 uo_calidad.em_campo.text      = ""
 uo_tipo_pallet.em_codigo.text = ""
 uo_tipo_pallet.em_campo.text  = ""

END IF
var_cliente = sle_cliente.text
IF len(Trim(uo_articulo.em_codigo.text))<> 0 Then
	uo_tipo_pallet.em_codigo.text = f_pallet_palarticulo_cliente(codigo_empresa,uo_articulo.em_codigo.text,var_cliente)
	uo_tipo_pallet.em_campo.text  = f_nombre_pallet_abr(codigo_empresa,uo_tipo_pallet.em_codigo.text)
END IF





end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type sle_cliente from u_em_campo within w_int_depmovent
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 933
integer y = 164
integer width = 384
integer taborder = 30
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes_deposito"
ue_filtro     = ""
end event

event modificado;call super::modificado;IF f_deposito_venclientes(codigo_empresa,sle_cliente.text) = "S" Then
	st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
ELSE
	st_nombre_cliente.text=""
END IF
IF LEN(st_nombre_cliente.text)=0 THEN 
   IF LEN(sle_cliente.text)<>0 Then f_activar_campo(sle_cliente)
   sle_cliente.text="" 
   Return
END IF

ver_movimientos()
end event

type uo_caja from u_em_campo_2 within w_int_depmovent
event destroy ( )
integer x = 1211
integer y = 516
integer width = 174
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_caja.em_campo.text=f_nombre_almartcaja_abr(codigo_empresa,uo_articulo.em_codigo.text,uo_caja.em_codigo.text)

IF Trim(uo_caja.em_campo.text)=""  or IsNull(uo_caja.em_campo.text)THEN 
 IF Trim(uo_caja.em_codigo.text)<>"" Then 
   uo_caja.em_campo.SetFocus()
 END IF
 uo_caja.em_campo.text=""
 uo_caja.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_almartcajas"
ue_filtro     = "almartcajas_articulo = '" + uo_articulo.em_codigo.text+ "'"




end event

type st_caja from statictext within w_int_depmovent
integer x = 1216
integer y = 444
integer width = 174
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Tc"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_int_depmovent
integer x = 14
integer y = 628
integer width = 2834
integer height = 796
string dataobject = "dw_int_depmovent2"
boolean vscrollbar = true
string icon = "\bmp\RINO.ICO"
borderstyle borderstyle = styleraised!
end type

on retrieveend;pb_borrar.visible = False
end on

event clicked;IF row<>0 THEN
 integer registros
 registros = dw_3.RowCount()
 pb_borrar.visible = TRUE
 IF registros>0 THEN
 This.SelectRow(0,FALSE)
 This.SelectRow(row,TRUE)
  END IF
END IF
end event


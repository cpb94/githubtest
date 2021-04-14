$PBExportHeader$w_int_depmovsal.srw
forward
global type w_int_depmovsal from w_int_con_empresa
end type
type st_fecha from statictext within w_int_depmovsal
end type
type pb_1 from upb_salir within w_int_depmovsal
end type
type st_tipomov from statictext within w_int_depmovsal
end type
type st_nombre_tipomov from statictext within w_int_depmovsal
end type
type st_cliente_etiqueta from statictext within w_int_depmovsal
end type
type st_nombre_cliente from statictext within w_int_depmovsal
end type
type em_fecha from u_em_campo within w_int_depmovsal
end type
type sle_tipomov from u_em_campo within w_int_depmovsal
end type
type sle_cliente from u_em_campo within w_int_depmovsal
end type
type dw_2 from datawindow within w_int_depmovsal
end type
type st_1 from statictext within w_int_depmovsal
end type
type st_2 from statictext within w_int_depmovsal
end type
type st_3 from statictext within w_int_depmovsal
end type
type em_tono from u_em_campo within w_int_depmovsal
end type
type em_calibre from u_em_campo within w_int_depmovsal
end type
type st_4 from statictext within w_int_depmovsal
end type
type st_texto_cantidad from statictext within w_int_depmovsal
end type
type em_cantidad from u_em_campo within w_int_depmovsal
end type
type cb_1 from u_boton within w_int_depmovsal
end type
type uo_articulo from u_em_campo_2 within w_int_depmovsal
end type
type uo_calidad from u_em_campo_2 within w_int_depmovsal
end type
type pb_borrar from upb_papelera within w_int_depmovsal
end type
type st_texto_cajas from statictext within w_int_depmovsal
end type
type st_texto_pallet from statictext within w_int_depmovsal
end type
type em_cajas from u_em_campo within w_int_depmovsal
end type
type em_pallet from u_em_campo within w_int_depmovsal
end type
type st_disponible from statictext within w_int_depmovsal
end type
type pb_imprimir from statictext within w_int_depmovsal
end type
type dw_3 from datawindow within w_int_depmovsal
end type
end forward

global type w_int_depmovsal from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 2953
integer height = 1664
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
st_fecha st_fecha
pb_1 pb_1
st_tipomov st_tipomov
st_nombre_tipomov st_nombre_tipomov
st_cliente_etiqueta st_cliente_etiqueta
st_nombre_cliente st_nombre_cliente
em_fecha em_fecha
sle_tipomov sle_tipomov
sle_cliente sle_cliente
dw_2 dw_2
st_1 st_1
st_2 st_2
st_3 st_3
em_tono em_tono
em_calibre em_calibre
st_4 st_4
st_texto_cantidad st_texto_cantidad
em_cantidad em_cantidad
cb_1 cb_1
uo_articulo uo_articulo
uo_calidad uo_calidad
pb_borrar pb_borrar
st_texto_cajas st_texto_cajas
st_texto_pallet st_texto_pallet
em_cajas em_cajas
em_pallet em_pallet
st_disponible st_disponible
pb_imprimir pb_imprimir
dw_3 dw_3
end type
global w_int_depmovsal w_int_depmovsal

type variables
  integer contador
  integer v_fila,v_altura,anyo
  String v_almacen
  string   v_zona,v_familia,v_sector
  decimal{4} v_cantidad,t_cantidad
  string ante_codigo_articulo,ante_codigo_calidad,ante_tono


  

// Defino la estructura de la tablas a procesar
   str_deplinubica      ubi
   str_depmovhis        mov


end variables

forward prototypes
public subroutine ver_movimientos ()
end prototypes

public subroutine ver_movimientos ();dw_3.retrieve(codigo_empresa,year(date(String(em_fecha.text))),sle_cliente.text,sle_tipomov.text)
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Introduccion movimientos salidas deposito"
This.title=istr_parametros.s_titulo_ventana
em_fecha.text=string(today())
// preparo datawindow ubicaciones
dw_2.settransobject(SQLCA)
dw_3.SetTransObject(SQLCA)





end event

on w_int_depmovsal.create
int iCurrent
call super::create
this.st_fecha=create st_fecha
this.pb_1=create pb_1
this.st_tipomov=create st_tipomov
this.st_nombre_tipomov=create st_nombre_tipomov
this.st_cliente_etiqueta=create st_cliente_etiqueta
this.st_nombre_cliente=create st_nombre_cliente
this.em_fecha=create em_fecha
this.sle_tipomov=create sle_tipomov
this.sle_cliente=create sle_cliente
this.dw_2=create dw_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.em_tono=create em_tono
this.em_calibre=create em_calibre
this.st_4=create st_4
this.st_texto_cantidad=create st_texto_cantidad
this.em_cantidad=create em_cantidad
this.cb_1=create cb_1
this.uo_articulo=create uo_articulo
this.uo_calidad=create uo_calidad
this.pb_borrar=create pb_borrar
this.st_texto_cajas=create st_texto_cajas
this.st_texto_pallet=create st_texto_pallet
this.em_cajas=create em_cajas
this.em_pallet=create em_pallet
this.st_disponible=create st_disponible
this.pb_imprimir=create pb_imprimir
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_fecha
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.st_tipomov
this.Control[iCurrent+4]=this.st_nombre_tipomov
this.Control[iCurrent+5]=this.st_cliente_etiqueta
this.Control[iCurrent+6]=this.st_nombre_cliente
this.Control[iCurrent+7]=this.em_fecha
this.Control[iCurrent+8]=this.sle_tipomov
this.Control[iCurrent+9]=this.sle_cliente
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.em_tono
this.Control[iCurrent+15]=this.em_calibre
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.st_texto_cantidad
this.Control[iCurrent+18]=this.em_cantidad
this.Control[iCurrent+19]=this.cb_1
this.Control[iCurrent+20]=this.uo_articulo
this.Control[iCurrent+21]=this.uo_calidad
this.Control[iCurrent+22]=this.pb_borrar
this.Control[iCurrent+23]=this.st_texto_cajas
this.Control[iCurrent+24]=this.st_texto_pallet
this.Control[iCurrent+25]=this.em_cajas
this.Control[iCurrent+26]=this.em_pallet
this.Control[iCurrent+27]=this.st_disponible
this.Control[iCurrent+28]=this.pb_imprimir
this.Control[iCurrent+29]=this.dw_3
end on

on w_int_depmovsal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_fecha)
destroy(this.pb_1)
destroy(this.st_tipomov)
destroy(this.st_nombre_tipomov)
destroy(this.st_cliente_etiqueta)
destroy(this.st_nombre_cliente)
destroy(this.em_fecha)
destroy(this.sle_tipomov)
destroy(this.sle_cliente)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_tono)
destroy(this.em_calibre)
destroy(this.st_4)
destroy(this.st_texto_cantidad)
destroy(this.em_cantidad)
destroy(this.cb_1)
destroy(this.uo_articulo)
destroy(this.uo_calidad)
destroy(this.pb_borrar)
destroy(this.st_texto_cajas)
destroy(this.st_texto_pallet)
destroy(this.em_cajas)
destroy(this.em_pallet)
destroy(this.st_disponible)
destroy(this.pb_imprimir)
destroy(this.dw_3)
end on

event activate;call super::activate;w_int_depmovsal = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_depmovsal
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_depmovsal
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_depmovsal
integer x = 18
integer y = 16
integer width = 2679
integer height = 88
end type

type st_fecha from statictext within w_int_depmovsal
integer x = 82
integer y = 136
integer width = 247
integer height = 80
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

type pb_1 from upb_salir within w_int_depmovsal
integer x = 2720
integer y = 12
integer width = 128
integer height = 108
integer taborder = 0
alignment htextalign = right!
end type

type st_tipomov from statictext within w_int_depmovsal
integer x = 37
integer y = 256
integer width = 293
integer height = 72
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

type st_nombre_tipomov from statictext within w_int_depmovsal
integer x = 672
integer y = 256
integer width = 951
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_cliente_etiqueta from statictext within w_int_depmovsal
integer x = 690
integer y = 136
integer width = 224
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
string text = "Cliente"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_cliente from statictext within w_int_depmovsal
integer x = 1367
integer y = 136
integer width = 1362
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_int_depmovsal
integer x = 357
integer y = 136
integer width = 283
integer height = 80
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

on modified;call u_em_campo::modified;ver_movimientos()

end on

type sle_tipomov from u_em_campo within w_int_depmovsal
integer x = 357
integer y = 252
integer width = 283
integer taborder = 30
end type

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de tipos de movimientos"
ue_datawindow = "dw_ayuda_deptipomov_salidas"
ue_filtro     = "interno = 'N'"
end event

event modificado;call super::modificado;st_nombre_tipomov.text=f_nombre_deptipomov_salida(codigo_empresa,sle_tipomov.text)
ver_movimientos()



end event

on rbuttondown;call u_em_campo::rbuttondown;if TRIM(st_nombre_tipomov.text)="" THEN
		istr_parametros.s_titulo_ventana = "Ayuda seleccion de tipos de movimientos"
		istr_parametros.s_nom_datawindow = "dw_ayuda_almtipomov_salidas"
      f_buscar(sle_tipomov,istr_parametros)
end if
end on

type sle_cliente from u_em_campo within w_int_depmovsal
integer x = 951
integer y = 136
integer width = 375
integer height = 80
integer taborder = 40
end type

event modificado;call super::modificado;st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
dw_2.Reset()
ver_movimientos()
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes_deposito"
ue_filtro     = ""
end event

type dw_2 from datawindow within w_int_depmovsal
event key pbm_dwnkey
integer x = 1006
integer y = 364
integer width = 1170
integer height = 492
integer taborder = 90
string dataobject = "dw_int_depmovsal1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;String referencia,tipo_pallet

IF currentrow >0 THEN
	This.SelectRow(0,FALSE)
	This.SelectRow(currentrow,TRUE)
	
	em_cantidad.text = String(GetItemNumber(currentrow,"existencias"))
	t_cantidad       = GetItemNumber(currentrow,"existencias")
	em_pallet.text   = ""
	em_cajas.text    = ""    
	
	uo_calidad.em_codigo.text =  GetItemString(currentrow,"calidad")
	em_tono.text              =  GetItemString(currentrow,"tonochar")
	em_calibre.text           =  String(GetItemNumber(currentrow,"calibre"))
	uo_calidad.em_campo.text  =  f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
	
	referencia  = This.getItemString(currentrow,"referencia")
	tipo_pallet = This.getItemString(currentrow,"tipo_pallet")
End If 

 


end event

event retrieveend;if rowcount > 0 then
	This.Event RowFocusChanged(1)
end if
end event

type st_1 from statictext within w_int_depmovsal
integer x = 9
integer y = 364
integer width = 626
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_depmovsal
integer x = 635
integer y = 364
integer width = 128
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cl"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_int_depmovsal
integer x = 763
integer y = 364
integer width = 160
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_tono from u_em_campo within w_int_depmovsal
integer x = 763
integer y = 440
integer width = 160
integer taborder = 70
string mask = "!!!!"
end type

on getfocus;call u_em_campo::getfocus;ante_tono = em_tono.text
end on

event modificado;call super::modificado;// Visualiza las lineas de ubicación a nivel de articulo-calidad-tono

if ante_tono<>em_tono.text then
   if trim(em_tono.text)<>"" THEN
      STRING is_filtro = ""
      if trim(uo_articulo.em_codigo.text)<>"" then

      is_filtro = " calidad = '" + uo_calidad.em_codigo.text + "'"	
      is_filtro = is_filtro + " AND tono = " + em_tono.text  
  
      dw_2.SetFilter(is_filtro)
      dw_2.Filter()
      dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text,sle_cliente.text)
    End If

  End If
End if
end event

type em_calibre from u_em_campo within w_int_depmovsal
integer x = 923
integer y = 440
integer width = 82
integer taborder = 80
maskdatatype maskdatatype = numericmask!
string mask = "#"
end type

type st_4 from statictext within w_int_depmovsal
integer x = 923
integer y = 364
integer width = 82
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "C"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_cantidad from statictext within w_int_depmovsal
integer x = 2510
integer y = 364
integer width = 343
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad from u_em_campo within w_int_depmovsal
integer x = 2510
integer y = 440
integer width = 343
integer taborder = 120
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modificado;call super::modificado;string cadena
long posi_aux, posi

em_pallet.text= ""
em_cajas.text = ""

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
                          dw_2.GetItemString(dw_2.getRow(),"caja"),&
								  integer(em_pallet.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
								  
posi_aux = 1
posi = pos(cadena,"|",1)
if posi <> 0 then
	em_pallet.text     = Mid(cadena,1,posi - 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <> 0 then
	em_cajas.text         = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cajas.text       = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if

posi = pos(cadena,"|",posi_aux)
if posi <>0 then
	em_cantidad.text      = Mid(cadena,posi_aux,posi - posi_aux + 1)
	posi_aux = posi + 1
end if
									 
   

//em_pallet.text       =Mid(cadena,1,6)
//em_cajas.text        =Mid(cadena,7,6)
//em_cantidad.text     =Mid(cadena,19,9)
//

end event

type cb_1 from u_boton within w_int_depmovsal
integer x = 2679
integer y = 540
integer width = 169
integer height = 120
integer taborder = 140
string text = "&Ok"
end type

event clicked;//CONTROLES DE VALORES

string mensaje
Dec{2}  var_conjunto

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

st_nombre_tipomov.text = f_nombre_deptipomov_salida(codigo_empresa,sle_tipomov.text)

IF trim(st_nombre_tipomov.text)="" or IsNull(st_nombre_tipomov.text) THEN
   mensaje="Introduzca el tipo de movimiento no existe"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   sle_tipomov.Setfocus()
   RETURN
END IF

IF f_tipo_almtipomov(codigo_empresa,sle_tipomov.text)="C" THEN
  st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
  IF trim(st_nombre_cliente.text)="" or IsNull(st_nombre_cliente.text) THEN
     mensaje="El cliente no existe."
     MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
     sle_cliente.Setfocus()
     RETURN
  END IF
END IF

IF trim(uo_articulo.em_campo.text)="" THEN
   mensaje="Introduzca el articulo"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_articulo.em_campo.Setfocus()
   RETURN
END IF
IF v_sector = "S" THEN
 IF trim(uo_calidad.em_campo.text)="" THEN
   mensaje="Introduzca la calidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   uo_calidad.em_campo.Setfocus()
   RETURN 
 END IF

IF em_tono.enabled=TRUE Then
 IF trim(em_tono.text)="" THEN
   mensaje="Introduzca el tono"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_tono.SetFocus()
   RETURN
 END IF
END IF

IF em_calibre.enabled=TRUE Then
 IF trim(em_calibre.text)="" THEN
   mensaje="Introduzca el calibre"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_calibre.SetFocus()
   RETURN
 END IF
END IF
END IF

IF dw_2.GetRow() =0 Then
   mensaje="Marcar Una Ubicacion"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   dw_2.SetFocus()
   RETURN
END IF


// Compara la cantidad con la ubicacion

IF Dec(em_cantidad.text) > t_cantidad THEN
   mensaje="La cantidad no puede ser mayor."
   MessageBox("! A t e n c i ó n ",mensaje,Exclamation!, OK!,1)
   em_cantidad.SetFocus()
   RETURN
END IF

IF v_sector = "S" THEN
 string codigo_articulo
 String codigo_calidad

 codigo_articulo = uo_articulo.em_codigo.text
 codigo_calidad  = uo_calidad.em_codigo.text

  SELECT almartcal.calidad INTO :codigo_calidad    FROM almartcal  
   WHERE (almartcal.empresa  = :codigo_empresa)
   AND   (almartcal.articulo = :codigo_articulo)
   AND   (almartcal.calidad  = :codigo_calidad);
   
   IF SQLCA.SQLCode<>0 THEN
     MessageBox("Calidad no  valida","Esta calidad no esta definida para el articulo",Exclamation!, OK!,1)
     uo_calidad.em_campo.text        = ""
     uo_calidad.em_codigo.text = ""
     uo_calidad.em_campo.Setfocus()
     Return
   END IF
END IF

   IF Dec(em_cantidad.text)=0 or trim(em_cantidad.text)="" THEN
   mensaje="Introduzca nº total de cantidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_cantidad.SetFocus()
   RETURN
END IF

// Control piezas por conjunto
var_conjunto= f_conjunto_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF var_conjunto<> 0 And Not IsNULL(var_conjunto) Then
 IF (Dec(String(Dec(em_cantidad.text)/var_conjunto,"##########")) * var_conjunto) <> Dec(em_cantidad.text) Then
  MessageBox("Cantidad no valida","Esta articulo va por conjuntos la cantidad a de ser multiplo de: " + String(var_conjunto),Exclamation!, OK!,1)
  f_activar_campo(em_cantidad)
  return
 END IF
END IF

// Proceso de Insercion //
//----------------------//
//---------------------------------------------------------------------
// Despues de todos los controles empezamos el proceso de inserción
//---------------------------------------------------------------------
// Valor de control funcionamiento
   integer bien
//------------------------------------------------------------------------
// Valores fijos para todos los casos
//------------------------------------------------------------------------
 ubi.empresa       = codigo_empresa
 mov.anyo          = year(date(String(em_fecha.text)))
 mov.usuario       = nombre_usuario
 ubi.almacen       = dw_2.GetItemString(dw_2.getRow(),"almacen")
 ubi.articulo      = uo_articulo.em_codigo.text
 ubi.calidad       = uo_calidad.em_codigo.text
 ubi.tonochar      = Trim(em_tono.text)
 ubi.calibre       = Integer(em_calibre.text)
 mov.fechmov       = DateTime(Date(String(em_fecha.text)))
 mov.f_alta        = Datetime(today(),now())
 mov.observaciones = ""
 mov.tipomov       = sle_tipomov.text
 ubi.tipo_pallet   = dw_2.GetItemString(dw_2.getRow(),"tipo_pallet")
 ubi.caja          = dw_2.GetItemString(dw_2.getRow(),"caja")
 
 SELECT  articulos.familia,articulos.formato,articulos.modelo,
         articulos.unidad  
    INTO :ubi.familia,:ubi.formato,:ubi.modelo, :ubi.tipo_unidad  
    FROM articulos  
   WHERE (articulos.empresa = :ubi.empresa ) AND  
         (articulos.codigo  = :ubi.articulo )   ;

         IF SQLCA.SQLCode<>0 THEN bien=1
 ubi.referencia   = f_componer_ref(ubi.articulo,&
                                   ubi.calidad,ubi.tonochar,&
                                   ubi.calibre)

ubi.cliente   = sle_cliente.text
ubi.f_alta    = DateTime(today(),now())
mov.cantidads = Dec(em_cantidad.text)
mov.cantidade = 0
ubi.existencias      = mov.cantidads
mov.empresa          = ubi.empresa
mov.almacen          = ubi.almacen
mov.articulo         = ubi.articulo
mov.cantidade        = 0
mov.codtercero       = sle_cliente.text
mov.numdoc           = ""
mov.situacion        = "N"
mov.observaciones    = ""
mov.tipo             = "C"
SetNull(mov.punteado)
mov.antexist=0      
mov.familia        = ubi.familia
mov.formato        = ubi.formato
mov.modelo         = ubi.modelo
mov.calidad        = ubi.calidad
mov.tonochar       = ubi.tonochar
mov.calibre        = ubi.calibre
mov.tipo_unidad    = ubi.tipo_unidad
mov.tipo_pallet    = ubi.tipo_pallet
mov.caja           = ubi.caja
mov.referencia     = ubi.referencia
mov.f_alta         = DateTime(today(),now())
//-------------------------------------------------------------------
v_almacen = dw_2.GetItemString(dw_2.GetRow(),"almacen")
//-------------------------------------------------------------------
// Variables de bloqueo
//-------------------------------------------------------------------
 titulo        =  Parent.title
 longitud      =  len(Trim(codigo_empresa))
 criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
 anyo          =  year(Date(em_fecha.text))
 longitud      =  len(trim(string(anyo)))
 criterio[2]   =  trim(string(anyo))+space(20-longitud)
 longitud      =  len(trim(v_almacen))
 criterio[3]   =  trim(v_almacen)+space(20-longitud)
 seleccion     =  criterio[1]+criterio[2]+criterio[3]
 tabla         =  "depparam"
//-----------------------------------------------------------------------
 IF NOT f_bloquear(tabla,seleccion,titulo) THEN 
 COMMIT Using sqlca; // control concurrencia //
   
  mov.nummov  = f_depparam_nummov(codigo_empresa,Year(Date(em_fecha.text)))
  // Variables para cargar el cursor

      integer cur_pedido,cur_linea,cur_anyo
      String  cur_empresa,cur_almacen
      decimal{4}  cur_existencias





	 Select deplinubica.existencias 
	 Into   :cur_existencias
	 From   deplinubica
	 Where  deplinubica.empresa     = :codigo_empresa
	 And    deplinubica.almacen     = :v_almacen 
	 And    deplinubica.referencia  = :ubi.referencia
	 And    deplinubica.tipo_pallet = :ubi.tipo_pallet
	 and    deplinubica.caja        = :ubi.caja;
	 IF SQLCA.SQLCODE = 0 Then
		IF cur_existencias = mov.cantidads Then
			Delete from deplinubica
				Where  deplinubica.empresa     = :codigo_empresa
			   And    deplinubica.almacen     = :v_almacen 
				And    deplinubica.referencia  = :ubi.referencia
				And    deplinubica.tipo_pallet = :ubi.tipo_pallet
				and    deplinubica.caja        = :ubi.caja;
		ELSE
			IF cur_existencias < mov.cantidads Then
				bien = 1
			ELSE
				Update deplinubica
				Set    deplinubica.existencias = deplinubica.existencias - :mov.cantidads
				Where  deplinubica.empresa     = :codigo_empresa
			   And    deplinubica.almacen     = :v_almacen 
				And    deplinubica.referencia  = :ubi.referencia
				And    deplinubica.tipo_pallet = :ubi.tipo_pallet
				And    deplinubica.caja        = :ubi.caja;
			END IF
		END IF
	ELSE
		f_mensaje("Error en proceso","Error al selecionar existencias" )	
		bien = 1
   END IF

// Grabo el movimiento en el historico
  IF NOT f_insert_depmovhis(mov) Then bien=1
  IF NOT f_actualiza_depnummov(codigo_empresa,Year(Date(em_fecha.text)),mov.nummov) THEN
     bien=1
  END IF

  f_desbloquear(tabla,seleccion,titulo)
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
ELSE
 pb_1.enabled=TRUE
 Return
END IF
pb_1.enabled=TRUE
ver_movimientos()
t_cantidad = 0
em_calibre.text=""
em_cantidad.text=""
em_tono.text=""
em_pallet.text=""
em_cajas.text=""
uo_articulo.em_campo.text=""
uo_calidad.em_campo.text=""
uo_articulo.em_codigo.text=""
dw_2.Reset()
uo_articulo.em_campo.SetFocus()



end event

type uo_articulo from u_em_campo_2 within w_int_depmovsal
integer x = 9
integer y = 440
integer width = 626
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;String var_tipo_unidad,var_descripcion
select descripcion,familia,unidad
Into :var_descripcion,:v_familia,:var_tipo_unidad
from articulos
Where articulos.empresa = :codigo_empresa
And   articulos.codigo = :uo_articulo.em_codigo.text;
uo_articulo.em_campo.text = var_descripcion
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF


// Visualiza las lineas de ubicación a nivel de articulo

If ante_codigo_articulo <> uo_articulo.em_codigo.text Then
   If trim(uo_articulo.em_campo.text)<>"" Then
      STRING is_filtro = ""
      dw_2.SetFilter(is_filtro)
      dw_2.Filter()  
      dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text,sle_cliente.text)
   End If
   st_texto_cantidad.text=f_nombre_unidad(f_codigo_articulo_unidad(codigo_empresa,uo_articulo.em_codigo.text))
	em_cantidad.Setmask(DecimalMask!,f_mascara_unidad(var_tipo_unidad))
	f_mascara_columna(dw_2,"existencias",f_mascara_unidad(var_tipo_unidad))
   v_sector  = f_sector_familia(codigo_empresa,v_familia)
   IF v_sector = "N" THEN
     uo_calidad.em_codigo.text = ""
     uo_calidad.em_campo.text  = ""
     em_tono.text     = "0"
     em_calibre.text  = "0"
     em_pallet.text   = "0"
     em_cajas.text    = "0"
     uo_calidad.enabled =FALSE
     em_tono.enabled    =FALSE
     em_calibre.enabled =FALSE
     em_pallet.enabled  =FALSE
     em_cajas.enabled   =FALSE
     IF dw_2.RowCount() <> 0 Then
        dw_2.SetRow(1)
        dw_2.SetFocus()
     ELSE
       // f_activar_campo(em_cantidad)
     END IF
   ELSE
     uo_calidad.enabled =TRUE
     em_tono.enabled    =TRUE
	  If f_tono_articulo(codigo_empresa,uo_articulo.em_codigo.text) = "N" Then 
		 em_tono.enabled    =FALSE
		 em_tono.text       ="0"
     END IF
     em_calibre.enabled =TRUE
	  If f_calibre_articulo(codigo_empresa,uo_articulo.em_codigo.text) = "N" Then
		  em_calibre.enabled    = FALSE
 	     em_calibre.text       = "0"
  	  End If
     em_pallet.enabled  =TRUE
     em_cajas.enabled   =TRUE
     // f_activar_campo(uo_calidad.em_campo)
   END IF
End If
end event

on getfocus;call u_em_campo_2::getfocus;ante_codigo_articulo = uo_articulo.em_codigo.text

ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type uo_calidad from u_em_campo_2 within w_int_depmovsal
integer x = 635
integer y = 440
integer width = 128
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
IF Trim(uo_calidad.em_campo.text)="" THEN 
 IF Trim(uo_calidad.em_codigo.text)<>"" Then uo_calidad.em_campo.SetFocus()
 uo_calidad.em_campo.text=""
 uo_calidad.em_codigo.text=""
END IF

// Visualiza las lineas de ubicación a nivel de articulo-calidad

if ante_codigo_calidad<>uo_calidad.em_codigo.text Then

   if trim(uo_calidad.em_campo.text)<>"" Then
      STRING is_filtro = ""
      if trim(uo_articulo.em_codigo.text)<>"" then
       	is_filtro = " calidad = '" + uo_calidad.em_codigo.text + "'"
	      dw_2.SetFilter(is_filtro)
         dw_2.Filter()
         dw_2.retrieve(codigo_empresa,uo_articulo.em_codigo.text,sle_cliente.text)
      End If
    End If
End if
end event

on getfocus;call u_em_campo_2::getfocus;ante_codigo_calidad = uo_calidad.em_codigo.text

ue_titulo     = "Ayuda seleccion de calidades"
ue_datawindow = "dw_ayuda_calidades"
ue_filtro     = ""
end on

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type pb_borrar from upb_papelera within w_int_depmovsal
boolean visible = false
integer x = 2615
integer y = 748
integer width = 155
integer height = 116
integer taborder = 130
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
  v_cantidad      =  dw_3.GetItemNumber(dw_3.getrow(),"cantidads")
  
  Select deplinubica.existencias Into :cur_existencias From deplinubica
	 Where  deplinubica.empresa     = :mov.empresa
	 And    deplinubica.almacen     = :mov.almacen 
	 And    deplinubica.referencia  = :mov.referencia
	 And    deplinubica.tipo_pallet = :mov.tipo_pallet;
	 IF SQLCA.SQLCODE = 0 Then
		IF v_cantidad + cur_existencias < 0 Then bien = 1
				Update deplinubica
				Set    deplinubica.existencias = deplinubica.existencias + :v_cantidad
				Where  deplinubica.empresa     = :mov.empresa
			   And    deplinubica.almacen     = :mov.almacen 
				And    deplinubica.referencia  = :mov.referencia
				And    deplinubica.tipo_pallet = :mov.tipo_pallet;
	ELSE
		iF v_cantidad < 0 Then bien = 1
			Select Max(linea) Into :xlinea From  deplinubica
			Where  deplinubica.empresa     = :mov.empresa
		   And    deplinubica.almacen     = :mov.almacen ;
   
			IF IsNull(xlinea) then xlinea = 0
			xlinea = xlinea + 1
	
	  	INSERT INTO deplinubica  
      (empresa,almacen,linea,articulo,familia,formato,modelo,calidad,   
       tono,calibre,existencias,cliente,tipo_unidad,referencia,f_alta,   
       tipo_pallet )  
	   VALUES (:mov.empresa,:mov.almacen,:xlinea,:mov.articulo,:mov.familia,   
      :mov.formato,:mov.modelo,:mov.calidad,:mov.tono,:mov.calibre,:v_cantidad,   
      :v_cliente,:mov.tipo_unidad,:mov.referencia,:mov.f_alta,:mov.tipo_pallet);
		 IF SQLCA.SQLCODE <> 0 Then bien = 1
   END IF
  
  
  
  
  
  
  
  
  IF bien = 0 Then
	COMMIT;
  ELSE
	ROLLBACK;
	f_mensaje("Error en datos","La operacion no se actualiza")
  END IF


ver_movimientos()
em_calibre.text=""
em_cantidad.text=""
em_tono.text=""
em_pallet.text=""
em_cajas.text=""
uo_articulo.em_campo.text=""
uo_calidad.em_campo.text=""
uo_articulo.em_codigo.text=""
dw_2.Reset()
uo_articulo.em_campo.SetFocus()

end event

type st_texto_cajas from statictext within w_int_depmovsal
integer x = 2304
integer y = 364
integer width = 206
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cajas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_pallet from statictext within w_int_depmovsal
integer x = 2181
integer y = 364
integer width = 123
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pal"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cajas from u_em_campo within w_int_depmovsal
integer x = 2304
integer y = 440
integer width = 206
integer taborder = 110
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###"
end type

event modificado;call super::modificado;string cadena

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
                          dw_2.GetItemString(dw_2.getRow(),"caja"),&
								  integer(em_pallet.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
em_pallet.text       =Mid(cadena,1,6)
em_cajas.text        =Mid(cadena,7,6)
em_cantidad.text     =Mid(cadena,19,9)


end event

type em_pallet from u_em_campo within w_int_depmovsal
integer x = 2181
integer y = 440
integer width = 123
integer taborder = 100
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###0"
string displaydata = "Ä"
end type

event getfocus;call super::getfocus;//TriggerEvent("modificado")
//call super::getfocus
end event

event modificado;call super::modificado;string cadena

if dw_2.getRow()=0 then Return

cadena=f_calculo_unidades(codigo_empresa,uo_articulo.em_codigo.text,&
                          dw_2.GetItemString(dw_2.getRow(),"tipo_pallet"),&
								  dw_2.GetItemString(dw_2.getRow(),"caja"),&
                          integer(em_pallet.text),&
                          integer(em_cajas.text),Dec(em_cantidad.text))
                      
em_pallet.text       =Mid(cadena,1,6)
em_cajas.text        =Mid(cadena,7,6)
em_cantidad.text     =Mid(cadena,19,9)


end event

type st_disponible from statictext within w_int_depmovsal
fontcharset fontcharset = ansi!
string facename = "System"
end type

type pb_imprimir from statictext within w_int_depmovsal
integer x = 1513
integer y = 156
fontcharset fontcharset = ansi!
string facename = "System"
end type

type dw_3 from datawindow within w_int_depmovsal
integer x = 37
integer y = 876
integer width = 2830
integer height = 548
string dataobject = "dw_int_depmovsal2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

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


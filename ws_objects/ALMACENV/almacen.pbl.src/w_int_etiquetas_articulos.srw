$PBExportHeader$w_int_etiquetas_articulos.srw
$PBExportComments$Obsoleto
forward
global type w_int_etiquetas_articulos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_etiquetas_articulos
end type
type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_articulos
end type
type pb_preliminar_etiquetas from upb_preliminar within w_int_etiquetas_articulos
end type
type st_2 from statictext within w_int_etiquetas_articulos
end type
type st_texto from statictext within w_int_etiquetas_articulos
end type
type gb_1 from groupbox within w_int_etiquetas_articulos
end type
type uo_articulo from u_em_campo_2 within w_int_etiquetas_articulos
end type
type st_3 from statictext within w_int_etiquetas_articulos
end type
type st_4 from statictext within w_int_etiquetas_articulos
end type
type cb_1 from u_boton within w_int_etiquetas_articulos
end type
type pb_2 from upb_papelera within w_int_etiquetas_articulos
end type
type dw_plantillas from datawindow within w_int_etiquetas_articulos
end type
type cb_recuperar_plantillas from u_boton within w_int_etiquetas_articulos
end type
type cb_grabar_plantillas from u_boton within w_int_etiquetas_articulos
end type
type cb_borrar_plantilla from u_boton within w_int_etiquetas_articulos
end type
type gb_2 from groupbox within w_int_etiquetas_articulos
end type
type em_plantilla from u_em_campo within w_int_etiquetas_articulos
end type
type em_etiquetas from u_em_campo within w_int_etiquetas_articulos
end type
type dw_proceso from datawindow within w_int_etiquetas_articulos
end type
type em_zoom from u_em_campo within w_int_etiquetas_articulos
end type
type st_5 from statictext within w_int_etiquetas_articulos
end type
type em_tono from u_em_campo within w_int_etiquetas_articulos
end type
type dw_1 from datawindow within w_int_etiquetas_articulos
end type
type uo_cliente from u_em_campo_2 within w_int_etiquetas_articulos
end type
type st_455 from statictext within w_int_etiquetas_articulos
end type
type st_6 from statictext within w_int_etiquetas_articulos
end type
type pb_imprimir_preli from picturebutton within w_int_etiquetas_articulos
end type
type uo_manejo from u_manejo_datawindow within w_int_etiquetas_articulos
end type
type st_333 from statictext within w_int_etiquetas_articulos
end type
type uo_caja from u_em_campo_2 within w_int_etiquetas_articulos
end type
type dw_preliminar from datawindow within w_int_etiquetas_articulos
end type
end forward

global type w_int_etiquetas_articulos from w_int_con_empresa
integer width = 2921
integer height = 1752
pb_1 pb_1
pb_imprimir_etiquetas pb_imprimir_etiquetas
pb_preliminar_etiquetas pb_preliminar_etiquetas
st_2 st_2
st_texto st_texto
gb_1 gb_1
uo_articulo uo_articulo
st_3 st_3
st_4 st_4
cb_1 cb_1
pb_2 pb_2
dw_plantillas dw_plantillas
cb_recuperar_plantillas cb_recuperar_plantillas
cb_grabar_plantillas cb_grabar_plantillas
cb_borrar_plantilla cb_borrar_plantilla
gb_2 gb_2
em_plantilla em_plantilla
em_etiquetas em_etiquetas
dw_proceso dw_proceso
em_zoom em_zoom
st_5 st_5
em_tono em_tono
dw_1 dw_1
uo_cliente uo_cliente
st_455 st_455
st_6 st_6
pb_imprimir_preli pb_imprimir_preli
uo_manejo uo_manejo
st_333 st_333
uo_caja uo_caja
dw_preliminar dw_preliminar
end type
global w_int_etiquetas_articulos w_int_etiquetas_articulos

type variables
String var_zoom
end variables

forward prototypes
public subroutine f_desactivar (boolean bool)
public subroutine f_zoom (string valor)
end prototypes

public subroutine f_desactivar (boolean bool);cb_1.enabled = bool
uo_articulo.enabled = bool
em_etiquetas.enabled = bool
dw_1.enabled = bool

end subroutine

public subroutine f_zoom (string valor);dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom =" + valor )
end subroutine

event ue_listar;Integer registros
 registros = dw_report.RowCount()
 IF registros=0 Then
   MessageBox("No existen registros","No realiza el listado",Exclamation!, OK!,1)
   Return
 END IF
 CALL Super::ue_listar


 



end event

event open;call super::open;istr_parametros.s_titulo_ventana="Listado etiquetas articulos"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_plantillas.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(hand!)
dw_plantillas.SetRowFocusIndicator(hand!)
dw_plantillas.Retrieve()
em_zoom.text="80"


end event

on w_int_etiquetas_articulos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir_etiquetas=create pb_imprimir_etiquetas
this.pb_preliminar_etiquetas=create pb_preliminar_etiquetas
this.st_2=create st_2
this.st_texto=create st_texto
this.gb_1=create gb_1
this.uo_articulo=create uo_articulo
this.st_3=create st_3
this.st_4=create st_4
this.cb_1=create cb_1
this.pb_2=create pb_2
this.dw_plantillas=create dw_plantillas
this.cb_recuperar_plantillas=create cb_recuperar_plantillas
this.cb_grabar_plantillas=create cb_grabar_plantillas
this.cb_borrar_plantilla=create cb_borrar_plantilla
this.gb_2=create gb_2
this.em_plantilla=create em_plantilla
this.em_etiquetas=create em_etiquetas
this.dw_proceso=create dw_proceso
this.em_zoom=create em_zoom
this.st_5=create st_5
this.em_tono=create em_tono
this.dw_1=create dw_1
this.uo_cliente=create uo_cliente
this.st_455=create st_455
this.st_6=create st_6
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_manejo=create uo_manejo
this.st_333=create st_333
this.uo_caja=create uo_caja
this.dw_preliminar=create dw_preliminar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir_etiquetas
this.Control[iCurrent+3]=this.pb_preliminar_etiquetas
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_texto
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.uo_articulo
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.pb_2
this.Control[iCurrent+12]=this.dw_plantillas
this.Control[iCurrent+13]=this.cb_recuperar_plantillas
this.Control[iCurrent+14]=this.cb_grabar_plantillas
this.Control[iCurrent+15]=this.cb_borrar_plantilla
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.em_plantilla
this.Control[iCurrent+18]=this.em_etiquetas
this.Control[iCurrent+19]=this.dw_proceso
this.Control[iCurrent+20]=this.em_zoom
this.Control[iCurrent+21]=this.st_5
this.Control[iCurrent+22]=this.em_tono
this.Control[iCurrent+23]=this.dw_1
this.Control[iCurrent+24]=this.uo_cliente
this.Control[iCurrent+25]=this.st_455
this.Control[iCurrent+26]=this.st_6
this.Control[iCurrent+27]=this.pb_imprimir_preli
this.Control[iCurrent+28]=this.uo_manejo
this.Control[iCurrent+29]=this.st_333
this.Control[iCurrent+30]=this.uo_caja
this.Control[iCurrent+31]=this.dw_preliminar
end on

on w_int_etiquetas_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir_etiquetas)
destroy(this.pb_preliminar_etiquetas)
destroy(this.st_2)
destroy(this.st_texto)
destroy(this.gb_1)
destroy(this.uo_articulo)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.pb_2)
destroy(this.dw_plantillas)
destroy(this.cb_recuperar_plantillas)
destroy(this.cb_grabar_plantillas)
destroy(this.cb_borrar_plantilla)
destroy(this.gb_2)
destroy(this.em_plantilla)
destroy(this.em_etiquetas)
destroy(this.dw_proceso)
destroy(this.em_zoom)
destroy(this.st_5)
destroy(this.em_tono)
destroy(this.dw_1)
destroy(this.uo_cliente)
destroy(this.st_455)
destroy(this.st_6)
destroy(this.pb_imprimir_preli)
destroy(this.uo_manejo)
destroy(this.st_333)
destroy(this.uo_caja)
destroy(this.dw_preliminar)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_etiquetas_articulos
integer y = 756
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_etiquetas_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_etiquetas_articulos
integer y = 24
integer width = 2638
integer height = 108
end type

type pb_1 from upb_salir within w_int_etiquetas_articulos
integer x = 2697
integer y = 24
integer height = 108
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_articulos
integer x = 558
integer y = 392
integer width = 123
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\print.bmp"
end type

event clicked;dw_report = dw_preliminar
dw_preliminar.reset()
Integer registro,registros,contador,reg,piezas
string descripcion,modelo,formato,calidad,ean13,articulo,tono,cliente,caja
dw_preliminar.SetTransObject(SQLCA)
contador = 0
f_zoom(em_zoom.text)
registros = dw_1.RowCount()
If registros = 0 then Return
For registro = 1 To registros
	articulo = dw_1.getitemString(registro,"articulo")
	caja		= dw_1.getitemString(registro,"caja")
	  SELECT articulos.modelo,   
         articulos.formato,   
         articulos.piezascaja,   
         articulos.descripcion,
			articulos.ean13
    INTO :modelo,   
         :formato,   
         :piezas,   
         :descripcion,
			:ean13
    FROM articulos  
   WHERE ( articulos.empresa = :codigo_empresa ) AND  
         ( articulos.codigo = :articulo )   ;

	SELECT ean13 INTO :ean13
	FROM almean13
	WHERE empresa = :codigo_empresa
	AND articulo = :articulo
	AND cliente  = :uo_cliente.em_codigo.text;
	
	SELECT piezascaja INTO :piezas
	FROM almartcajas
	WHERE empresa = :codigo_empresa
	AND caja =:caja
	AND articulo = :articulo;

	
	FOR reg = 1 To dw_1.GetItemNumber(registro,"etiquetas")
  	 contador =contador + 1
  	 dw_preliminar.InsertRow(contador)
	IF f_ean_13_correcto(ean13) = FALSE then 
		messagebox("ERROR","EL EAN 13 de este articulo no es correcto")
		dw_preliminar.SetItem(contador,"texto","")
	end if
	IF not isnull(ean13) then 
		dw_preliminar.SetItem(contador,"texto",ean13)
	else
		dw_preliminar.SetItem(contador,"texto","")
	end if
	 dw_preliminar.SetItem(contador,"modelo",f_nombre_articulo(codigo_empresa,articulo))
	 dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,formato))
	 dw_preliminar.SetItem(contador,"piezas",piezas)
	 dw_preliminar.SetItem(contador,"calidad","1ª")
	 dw_preliminar.SetItem(contador,"descripcion",descripcion)
 	 dw_preliminar.SetItem(contador,"tono",dw_1.GetItemString(registro,"tono"))
  NEXT
	f_contador_procesos(registro,registros)
Next
   
st_texto.text= String(dw_preliminar.RowCount()) + " Etiquetas"
Parent.TriggerEvent("ue_listar")
f_activar_campo(uo_articulo.em_campo)
end event

type pb_preliminar_etiquetas from upb_preliminar within w_int_etiquetas_articulos
integer x = 681
integer y = 392
integer taborder = 0
boolean originalsize = false
end type

event clicked;dw_1.AcceptText()
dw_preliminar.reset()
Integer registro,registros,contador,reg,piezas
string descripcion,modelo,formato,calidad,ean13,articulo,tono,cliente,caja
dw_preliminar.SetTransObject(SQLCA)
contador = 0
f_zoom(em_zoom.text)
registros = dw_1.RowCount()
If registros = 0 then Return
For registro = 1 To registros
	articulo = dw_1.getitemString(registro,"articulo")
	caja		= dw_1.getitemString(registro,"caja")
	  SELECT articulos.modelo,   
         articulos.formato,   
         articulos.piezascaja,   
         articulos.descripcion,
			articulos.ean13
    INTO :modelo,   
         :formato,   
         :piezas,   
         :descripcion,
			:ean13
    FROM articulos  
   WHERE ( articulos.empresa = :codigo_empresa ) AND  
         ( articulos.codigo = :articulo )   ;

	SELECT ean13 INTO :ean13
	FROM almean13
	WHERE empresa = :codigo_empresa
	AND articulo = :articulo
	AND cliente  = :uo_cliente.em_codigo.text;
	
	SELECT piezascaja INTO :piezas
	FROM almartcajas
	WHERE empresa = :codigo_empresa
	AND caja =:caja
	AND articulo = :articulo;

	
	FOR reg = 1 To dw_1.GetItemNumber(registro,"etiquetas")
  	 contador =contador + 1
  	 dw_preliminar.InsertRow(contador)
	IF f_ean_13_correcto(ean13) = FALSE then 
		messagebox("ERROR","EL EAN 13 de este articulo no es correcto")
		dw_preliminar.SetItem(contador,"texto","")
	end if
	IF not isnull(ean13) then 
		dw_preliminar.SetItem(contador,"texto",ean13)
	else
		dw_preliminar.SetItem(contador,"texto","")
	end if
	 dw_preliminar.SetItem(contador,"modelo",f_nombre_articulo(codigo_empresa,articulo))
	 dw_preliminar.SetItem(contador,"formato",f_nombre_formato_abr(codigo_empresa,formato))
	 dw_preliminar.SetItem(contador,"piezas",piezas)
	 dw_preliminar.SetItem(contador,"calidad","1ª")
	 dw_preliminar.SetItem(contador,"descripcion",descripcion)
 	 dw_preliminar.SetItem(contador,"tono",dw_1.GetItemString(registro,"tono"))
  NEXT
	f_contador_procesos(registro,registros)
Next
   
st_texto.text= String(dw_preliminar.RowCount()) + " Etiquetas"
uo_manejo.visible = TRUE
pb_imprimir_preli.visible = TRUE
dw_preliminar.visible =  TRUE
em_zoom.visible =  TRUE
f_desactivar(FALSE)
  


end event

type st_2 from statictext within w_int_etiquetas_articulos
integer x = 187
integer y = 392
integer width = 352
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Etiquetas  "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto from statictext within w_int_etiquetas_articulos
boolean visible = false
integer x = 741
integer y = 388
integer width = 704
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_int_etiquetas_articulos
integer x = 174
integer y = 348
integer width = 640
integer height = 160
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type uo_articulo from u_em_campo_2 within w_int_etiquetas_articulos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 805
integer y = 236
integer width = 654
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)

IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
 Return
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""


end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within w_int_etiquetas_articulos
boolean visible = false
integer x = 1870
integer y = 1284
integer width = 869
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Texto   Plantilla "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_int_etiquetas_articulos
integer x = 2190
integer y = 160
integer width = 402
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Etiquetas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_1 from u_boton within w_int_etiquetas_articulos
boolean visible = false
integer x = 1467
integer y = 376
integer width = 311
integer height = 112
integer taborder = 0
string text = "&Aceptar"
end type

event clicked;If Trim(uo_articulo.em_campo.text) = "" then
	f_mensaje("Campo obligatorio","Introduzca el articulo")
	f_activar_campo(uo_articulo.em_campo)
	Return
End If

If Trim(uo_caja.em_campo.text) = "" then
	f_mensaje("Campo obligatorio","Introduzca la caja")
	f_activar_campo(uo_caja.em_campo)
	Return
End If

If Trim(em_etiquetas.text) = ""  or em_etiquetas.text ="0" then
	f_mensaje("Campo obligatorio","Introduzca el articulo")
	f_activar_campo(uo_articulo.em_campo)
	Return
End If

Integer registro
registro = dw_1.RowCount()
registro = registro + 1
dw_1.InsertRow(registro)
dw_1.SetItem(registro,"articulo",uo_articulo.em_codigo.text)
dw_1.SetItem(registro,"etiquetas",Integer(em_etiquetas.text))
dw_1.setitem(registro,"empresa",codigo_empresa)
dw_1.setitem(registro,"tono",em_tono.text)
dw_1.setitem(registro,"caja",uo_caja.em_codigo.text)

uo_articulo.em_campo.text  = "" 
uo_articulo.em_codigo.text = "" 
uo_caja.em_campo.text  = "" 
uo_caja.em_codigo.text = "" 
em_etiquetas.text          = ""
em_tono.text					= ""

f_activar_campo(uo_articulo.em_campo)
end event

type pb_2 from upb_papelera within w_int_etiquetas_articulos
integer x = 2565
integer y = 516
integer width = 183
integer height = 160
integer taborder = 0
end type

event clicked;call super::clicked;IF dw_1.GetRow() = 0 Then Return
dw_1.DeleteRow(dw_1.GetRow())
end event

type dw_plantillas from datawindow within w_int_etiquetas_articulos
boolean visible = false
integer x = 82
integer y = 1188
integer width = 1289
integer height = 360
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_int_etiquetas_articulos2"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_recuperar_plantillas from u_boton within w_int_etiquetas_articulos
event clicked pbm_bnclicked
boolean visible = false
integer x = 1422
integer y = 1252
integer height = 92
integer taborder = 0
string text = "&Recuperar"
end type

event clicked;call super::clicked;Integer reg,reg1,var_etiquetas
String var_texto
IF dw_plantillas.GetRow() = 0 Then
	 f_mensaje("La operación puede realizar","No existen plantillas seleccionadas")
	 Return
END IF
dw_1.Reset()
reg = dw_proceso.Retrieve(dw_plantillas.GetItemNumber(dw_plantillas.GetRow(),"plantilla"))
For reg1 = 1 To reg
	var_texto = dw_proceso.GetItemString(reg1,"texto")
	var_etiquetas = dw_proceso.GetItemNumber(reg1,"etiquetas")
	dw_1.InsertRow(reg1)
	dw_1.SetItem(reg1,"articulo",var_texto)
	dw_1.SetItem(reg1,"etiquetas",var_etiquetas)
	f_contador_procesos(reg1,reg)
Next
end event

type cb_grabar_plantillas from u_boton within w_int_etiquetas_articulos
event clicked pbm_bnclicked
boolean visible = false
integer x = 1422
integer y = 1348
integer height = 92
integer taborder = 0
string text = "&Grabar"
end type

event clicked;call super::clicked;Dec{0} var_plantilla,var_etiquetas,reg
String var_descripcion,var_texto
dw_1.AcceptText()
If em_plantilla.text = "" Then
   f_mensaje("La operación puede realizar","Introduzca la descripcion de la plantilla")	
	f_activar_campo(em_plantilla)
	Return
END IF
    SELECT max(almartplantilla.plantilla)  
    INTO   :var_plantilla  
    FROM   almartplantilla ;
	 If IsNull(var_plantilla) Then  var_plantilla = 0
	 var_plantilla = var_plantilla + 1
     var_descripcion = em_plantilla.text
FOR reg = 1 To dw_1.RowCount()
	var_texto  = dw_1.GetItemString(reg,"articulo")
	var_etiquetas = dw_1.GetItemNumber(reg,"etiquetas")
	  INSERT INTO almartplantilla  
         ( plantilla,   
           descripcion,   
           texto,   
           etiquetas )  
  VALUES ( :var_plantilla,   
           :var_descripcion,   
           :var_texto,   
           :var_etiquetas )  ;

Next
COMMIT;
dw_plantillas.Retrieve()
em_plantilla.text = ""
end event

type cb_borrar_plantilla from u_boton within w_int_etiquetas_articulos
event clicked pbm_bnclicked
boolean visible = false
integer x = 1422
integer y = 1440
integer height = 92
integer taborder = 0
string text = "&Borrar"
end type

event clicked;call super::clicked;IF dw_plantillas.GetRow() = 0 Then
	 f_mensaje("La operación puede realizar","No existen plantillas seleccionadas")
	 Return
END IF

Integer plantilla

plantilla = dw_plantillas.GetItemNumber(dw_plantillas.GetRow(),"plantilla")
 DELETE FROM almartplantilla  
 WHERE       almartplantilla.plantilla = :plantilla;
 dw_plantillas.Retrieve()
COMMIT;

end event

type gb_2 from groupbox within w_int_etiquetas_articulos
boolean visible = false
integer x = 1394
integer y = 1188
integer width = 457
integer height = 364
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 12632256
string text = "Plantillas"
end type

type em_plantilla from u_em_campo within w_int_etiquetas_articulos
event tecla_tabulador pbm_custom04
boolean visible = false
integer x = 1865
integer y = 1356
integer width = 878
integer taborder = 0
end type

event tecla_tabulador;call super::tecla_tabulador;cb_1.TriggerEvent(Clicked!)
end event

type em_etiquetas from u_em_campo within w_int_etiquetas_articulos
integer x = 2190
integer y = 236
integer width = 402
integer height = 88
integer taborder = 60
end type

event modificado;call super::modificado;cb_1.triggerEvent(Clicked!)
end event

type dw_proceso from datawindow within w_int_etiquetas_articulos
boolean visible = false
integer x = 5
integer width = 494
integer height = 92
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_proceso_almartplantilla"
boolean livescroll = true
end type

type em_zoom from u_em_campo within w_int_etiquetas_articulos
boolean visible = false
integer x = 2729
integer y = 376
integer width = 133
integer taborder = 100
string mask = "#####"
string displaydata = ""
end type

event modified;call super::modified;f_zoom(This.text)
end event

event tecla_tabulador;call super::tecla_tabulador;f_activar_campo(em_zoom)
end event

type st_5 from statictext within w_int_etiquetas_articulos
integer x = 1467
integer y = 160
integer width = 283
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tono"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_tono from u_em_campo within w_int_etiquetas_articulos
integer x = 1463
integer y = 236
integer width = 279
integer height = 88
integer taborder = 40
end type

type dw_1 from datawindow within w_int_etiquetas_articulos
integer x = 14
integer y = 516
integer width = 2551
integer height = 672
integer taborder = 70
string dataobject = "dw_int_etiquetas_articulos1"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type uo_cliente from u_em_campo_2 within w_int_etiquetas_articulos
event destroy ( )
integer x = 32
integer y = 236
integer width = 773
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
IF Trim(uo_cliente.em_campo.text)="" THEN 
 IF Trim(uo_cliente.em_codigo.text)<>"" Then uo_cliente.em_campo.SetFocus()
 uo_cliente.em_campo.text=""
 uo_cliente.em_codigo.text=""
 Return
END IF

end event

event getfocus;ue_titulo     = "Ayuda seleccion de clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""


end event

type st_455 from statictext within w_int_etiquetas_articulos
integer x = 805
integer y = 160
integer width = 663
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

type st_6 from statictext within w_int_etiquetas_articulos
integer x = 37
integer y = 160
integer width = 768
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_imprimir_preli from picturebutton within w_int_etiquetas_articulos
boolean visible = false
integer x = 2578
integer y = 384
integer width = 110
integer height = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\print.bmp"
end type

event clicked;str_parametros pa
pa.s_listado = dw_preliminar.DataObject
OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(uo_articulo.em_campo)
end event

type uo_manejo from u_manejo_datawindow within w_int_etiquetas_articulos
event destroy ( )
boolean visible = false
integer x = 2107
integer y = 332
integer taborder = 80
end type

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

event valores;call super::valores;dw_data = dw_preliminar
end event

type st_333 from statictext within w_int_etiquetas_articulos
integer x = 1751
integer y = 160
integer width = 439
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Caja"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_caja from u_em_campo_2 within w_int_etiquetas_articulos
event destroy ( )
integer x = 1746
integer y = 236
integer width = 443
integer height = 88
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_caja.em_campo.text=f_nombre_caja(codigo_empresa,uo_caja.em_codigo.text)

IF Trim(uo_caja.em_campo.text)="" THEN 
 IF Trim(uo_caja.em_codigo.text)<>"" Then uo_caja.em_campo.SetFocus()
 uo_caja.em_campo.text=""
 uo_caja.em_codigo.text=""
 Return
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_cajas"
ue_filtro     = ""


end event

type dw_preliminar from datawindow within w_int_etiquetas_articulos
boolean visible = false
integer x = 27
integer y = 520
integer width = 1239
integer height = 804
boolean bringtotop = true
boolean titlebar = true
string title = "Preliminar"
string dataobject = "dw_int_etiquetas_articulos"
boolean controlmenu = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;uo_manejo.visible = FALSE
dw_preliminar.visible   = False
pb_imprimir_preli.visible = False
em_zoom.visible =  FALSE
f_desactivar(TRUE)
dw_preliminar.reset()
f_activar_campo(uo_articulo.em_campo)
end event


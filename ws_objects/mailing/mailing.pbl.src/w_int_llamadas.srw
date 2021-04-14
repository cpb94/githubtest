$PBExportHeader$w_int_llamadas.srw
$PBExportComments$Introduccion llamadas de contactos.
forward
global type w_int_llamadas from wi_mvent_con_empresa
end type
type st_nombre_contacto from statictext within w_int_llamadas
end type
type dw_llamadas2 from datawindow within w_int_llamadas
end type
type pb_contactos from up_carpeta within w_int_llamadas
end type
type cb_mapa from commandbutton within w_int_llamadas
end type
type cb_subdis from commandbutton within w_int_llamadas
end type
type cb_distri from commandbutton within w_int_llamadas
end type
type dw_subdistribuidores from datawindow within w_int_llamadas
end type
type p_1 from picturebutton within w_int_llamadas
end type
type dw_distribuidores from datawindow within w_int_llamadas
end type
type gb_1 from groupbox within w_int_llamadas
end type
end forward

global type w_int_llamadas from wi_mvent_con_empresa
integer width = 3003
integer height = 1668
st_nombre_contacto st_nombre_contacto
dw_llamadas2 dw_llamadas2
pb_contactos pb_contactos
cb_mapa cb_mapa
cb_subdis cb_subdis
cb_distri cb_distri
dw_subdistribuidores dw_subdistribuidores
p_1 p_1
dw_distribuidores dw_distribuidores
gb_1 gb_1
end type
global w_int_llamadas w_int_llamadas

type variables
Integer periodo,contador
String campanya

end variables

forward prototypes
public subroutine f_orden (string empresa, string contacto, integer anyo)
public subroutine f_orden_max ()
end prototypes

public subroutine f_orden (string empresa, string contacto, integer anyo);contador =0


end subroutine

public subroutine f_orden_max ();String var_empresa,contacto
Integer var_anyo,anyo
contacto = sle_valor.text
anyo     =year(Today())
SELECT   max(mllamadas.contador)  
INTO     :contador  
FROM     mllamadas  
WHERE   (mllamadas.empresa = :codigo_empresa )
AND     (mllamadas.anyo    = :anyo );
IF IsNull(contador) Then  contador=0
contador  = contador + 1
end subroutine

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
longitud      =  len(trim(String(periodo)))
criterio[3]   =  trim(String(periodo))+space(20-longitud)
longitud      =  len(trim(String(today())))
criterio[4]   =  trim(String(today()))+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]+criterio[4]
tabla         = "mllamadas"

dw_1.Retrieve(codigo_empresa,sle_valor.text,periodo,contador)
// Selecciona la campaña activa segun la fecha de entrada
IF dw_1.RowCount() = 0 Then
	datetime fecha
	fecha = datetime(today(),now())
	
	Select mcampanya.codigo
	Into   :campanya
	From   mcampanya
	WHERE  mcampanya.empresa  = :codigo_empresa  AND  
			 (mcampanya.fdesde <= :fecha and mcampanya.fhasta >= :fecha) ;
				 
	if IsNull(campanya) then campanya=""
	  
	if Trim(campanya)="" then
		  f_mensaje("!Atención¡","No hay campaña activa para esta fecha")
		  f_activar_campo(sle_valor)
		  Return
	End if

ENd IF

CALL Super::ue_recuperar


end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.SetItem(dw_1.GetRow(),"empresa",codigo_empresa)
dw_1.SetItem(dw_1.GetRow(),"anyo",periodo)
dw_1.SetItem(dw_1.GetRow(),"contador",contador)
dw_1.SetItem(dw_1.GetRow(),"contacto",sle_valor.text)
dw_1.SetItem(dw_1.GetRow(),"enviados","N")
dw_1.SetItem(dw_1.GetRow(),"imp_etiquetas","N")
dw_1.SetItem(dw_1.GetRow(),"fecha",DateTime(today()))
dw_1.SetItem(dw_1.GetRow(),"campanya",campanya)
Datetime fecha
fecha = DateTime(today(),now())

dw_1.SetItem(dw_1.GetRow(),"fecha_alta",fecha)
dw_1.SetItem(dw_1.GetRow(),"provincia",f_provincia_contacto(codigo_empresa,sle_valor.text))
dw_1.SetItem(dw_1.GetRow(),"pais",f_pais_contacto(codigo_empresa,sle_valor.text))



dw_distribuidores.Retrieve(codigo_empresa,'C',&
                           f_pais_contacto(codigo_empresa,sle_valor.text),&
                           dw_1.GetItemString(dw_1.GetRow(),"provincia"),'S')

cb_subdis.visible = TRUE
end event

event key;IF KeyDown(KeyTab!) THEN  f_orden(codigo_empresa,sle_valor.text,periodo)
CALL Super::key

end event

event open;call super::open;   istr_parametros.s_titulo_ventana = "Introducción de llamadas"
   This.title = istr_parametros.s_titulo_ventana
   
periodo =  Year(Today())
dw_llamadas2.SetTransObject(SQLCA)
dw_distribuidores.SetTransObject(SQLCA)
dw_subdistribuidores.SetTransObject(SQLCA)
clave=""


end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;dw_llamadas2.enabled=FALSE
pb_contactos.enabled=FALSE
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;dw_llamadas2.enabled=TRUE
pb_contactos.enabled=TRUE
end on

event ue_desbloquear;call super::ue_desbloquear;dw_1.Reset()

periodo = year(today())
f_orden(codigo_empresa,sle_valor.text,periodo)

end event

on w_int_llamadas.create
int iCurrent
call super::create
this.st_nombre_contacto=create st_nombre_contacto
this.dw_llamadas2=create dw_llamadas2
this.pb_contactos=create pb_contactos
this.cb_mapa=create cb_mapa
this.cb_subdis=create cb_subdis
this.cb_distri=create cb_distri
this.dw_subdistribuidores=create dw_subdistribuidores
this.p_1=create p_1
this.dw_distribuidores=create dw_distribuidores
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nombre_contacto
this.Control[iCurrent+2]=this.dw_llamadas2
this.Control[iCurrent+3]=this.pb_contactos
this.Control[iCurrent+4]=this.cb_mapa
this.Control[iCurrent+5]=this.cb_subdis
this.Control[iCurrent+6]=this.cb_distri
this.Control[iCurrent+7]=this.dw_subdistribuidores
this.Control[iCurrent+8]=this.p_1
this.Control[iCurrent+9]=this.dw_distribuidores
this.Control[iCurrent+10]=this.gb_1
end on

on w_int_llamadas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_nombre_contacto)
destroy(this.dw_llamadas2)
destroy(this.pb_contactos)
destroy(this.cb_mapa)
destroy(this.cb_subdis)
destroy(this.cb_distri)
destroy(this.dw_subdistribuidores)
destroy(this.p_1)
destroy(this.dw_distribuidores)
destroy(this.gb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within w_int_llamadas
integer x = 27
integer y = 268
integer width = 1742
integer height = 352
integer taborder = 50
string dataobject = "dw_int_llamadas1"
end type

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"tipo_revista")
f_valores_numericos(dw_1,"provincia")
f_valores_numericos(dw_1,"pais")

end on

on dw_1::itemfocuschanged;call wi_mvent_con_empresa`dw_1::itemfocuschanged; IF This.GetRow()=0 Then Return

     dw_distribuidores.Retrieve(codigo_empresa,'C',&
                               f_pais_contacto(codigo_empresa,sle_valor.text),&
                               This.GetItemString(This.GetRow(),"provincia"),'S')
     

end on

event dw_1::rbuttondown;valor_empresa = TRUE
bus_filtro=""
String  var_pais 
 var_pais = dw_1.GetItemString(dw_1.GetRow(),"pais")
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipo_revista"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE REVISTA "
 		bus_datawindow = "dw_ayuda_revistas"
   CASE "provincia"
      bus_titulo     = "VENTANA SELECCION DE PROVINCIAS "
 		bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais =  '" + var_pais + "'"
	   valor_empresa = FALSE
 CASE "pais"
      bus_titulo     = "VENTANA SELECCION DE PAISES "
 		bus_datawindow = "dw_ayuda_paises"
      bus_filtro     =""
      valor_empresa = FALSE
CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

on dw_1::itemchanged;call wi_mvent_con_empresa`dw_1::itemchanged;This.TriggerEvent("itemfocuschanged")
end on

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
IF dw_1.GetRow() = 0 Then return	
valor_empresa = True
String  var_pais 
 var_pais = dw_1.GetItemString(dw_1.GetRow(),"pais")
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipo_revista"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE REVISTAS "
 		bus_datawindow = "dw_ayuda_revistas"
  CASE "provincia"
      valor_empresa = False
		bus_titulo     = "VENTANA SELECCION DE PROVINCIAS "
 		bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais =  '" + var_pais + "'"
CASE "pais"
      valor_empresa = False
		bus_titulo     = "VENTANA SELECCION DE PAISES "
 		bus_datawindow = "dw_ayuda_paises"
      bus_filtro     =""
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_1::clicked;call super::clicked;valor_empresa = TRUE
string ls_objeto
datawindow var_datawindow
str_parametros lstr_param

// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_int_llamadas"
CHOOSE CASE ls_objeto
  
CASE 'pb_tipo_revista'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_revista")
   OpenWithParm(wi_mant_revistas,lstr_param)  
CASE 'pb_provincia'	
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_pais_contacto(codigo_empresa,sle_valor.text)
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)  
   valor_empresa = FALSE
CASE 'pb_pais'
   lstr_param.s_argumentos[2]=f_pais_contacto(codigo_empresa,sle_valor.text)
   OpenWithParm(wi_mant_paises,lstr_param)  
   valor_empresa = FALSE
END CHOOSE





end event

type st_1 from wi_mvent_con_empresa`st_1 within w_int_llamadas
integer x = 64
integer y = 168
integer width = 311
string text = "Contacto"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_int_llamadas
integer x = 265
integer y = 640
integer width = 402
integer height = 76
end type

event cb_insertar::clicked;IF cb_insertar.enabled = TRUE Then
	
	dw_1.acceptText()
	String var_tipo_revista,var_provincia,titulo_revista,var_pais,nombre_provincia,nombre_pais
	
	If dw_1.GetRow() = 0 Then return
	var_tipo_revista = dw_1.GetItemString(dw_1.GetRow(),"tipo_revista")
	var_provincia    = dw_1.GetItemString(dw_1.GetRow(),"provincia")
	var_pais         = dw_1.GetItemString(dw_1.GetRow(),"pais")

	titulo_revista = f_nombre_revista(codigo_empresa,var_tipo_revista)
	nombre_provincia = f_nombre_provincia(var_pais,var_provincia)
	nombre_pais      = f_nombre_pais(var_pais)
	
	IF IsNull(var_tipo_revista) or Trim(var_tipo_revista)="" or trim(titulo_revista)="" Then
		MessageBox("Campo obligatorio","Introduzca el tipo de revista",Exclamation!, OK!,1)
		dw_1.SetColumn("tipo_revista")
		dw_1.SetFocus()
		Return
	END IF

	IF IsNull(var_provincia) or Trim(var_provincia)="" or trim(nombre_provincia)="" Then
		MessageBox("Campo obligatorio","Introduzca la provincia",Exclamation!, OK!,1)
		dw_1.SetColumn("provincia")
		dw_1.SetFocus()
		Return
	END IF
	
	IF IsNull(var_pais) or Trim(var_pais)="" or trim(nombre_pais)="" Then
		MessageBox("Campo obligatorio","Introduzca el pais",Exclamation!, OK!,1)
		dw_1.SetColumn("pais")
		dw_1.SetFocus()
		Return
	END IF
	
	
	IF f_distribuidores_provincia(codigo_empresa,var_pais,var_provincia) = 0 Then
		MessageBox("No existen distribuidores a esta provincia","Introduzca la provincia",Exclamation!, OK!,1)
		dw_1.SetColumn("provincia")
		dw_1.SetFocus()
		Return
	END IF

END IF

IF insercion ="S" Then
	  f_orden_max()
	  dw_1.SetItem(dw_1.GetRow(),"contador",contador)
END IF

Call super::clicked
dw_llamadas2.Retrieve(codigo_empresa,sle_valor.text)
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_int_llamadas
integer x = 667
integer y = 640
integer width = 402
integer height = 76
end type

on cb_borrar::clicked;call wi_mvent_con_empresa`cb_borrar::clicked;dw_llamadas2.Retrieve(codigo_empresa,year(today()),sle_valor.text)
end on

type sle_valor from wi_mvent_con_empresa`sle_valor within w_int_llamadas
integer x = 384
integer y = 164
integer width = 361
end type

event sle_valor::modificado;call super::modificado;st_nombre_contacto.text=f_razon_o_compuesto_contacto(codigo_empresa,This.text)

IF Trim(st_nombre_contacto.text)="" THEN 
   IF Trim(sle_valor.text)<>"" Then f_activar_campo(sle_valor)
   sle_valor.text=""
End if

dw_llamadas2.Retrieve(codigo_empresa,sle_valor.text)	









end event

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_titulo     = "Ayuda seleccion de contactos"
ue_datawindow = "dw_ayuda_contactos"
ue_filtro     = ""
isle_campo    = This

IF Not IsNull(clave) and Trim(clave)<> "" Then
 sle_valor.text = clave
 clave = ""
END IF

end on

type cb_salir from wi_mvent_con_empresa`cb_salir within w_int_llamadas
integer x = 1070
integer y = 640
integer width = 402
integer height = 76
end type

on cb_salir::clicked;IF cb_insertar.enabled= TRUE Then
  dw_distribuidores.Reset()
  cb_subdis.visible = FALSE
  cb_distri.visible = FALSE
  dw_subdistribuidores.Reset()
  dw_distribuidores.visible = true
END IF

Call super::clicked


end on

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_int_llamadas
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_int_llamadas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_int_llamadas
integer x = 18
integer y = 24
integer width = 2697
end type

type st_nombre_contacto from statictext within w_int_llamadas
integer x = 846
integer y = 164
integer width = 1294
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

type dw_llamadas2 from datawindow within w_int_llamadas
integer x = 1774
integer y = 268
integer width = 1061
integer height = 444
boolean bringtotop = true
string dataobject = "dw_int_llamadas2"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row =0 Then Return
contador       = This.GetItemNumber(Row,"contador")
periodo        = This.GetItemNumber(Row,"anyo")

dw_1.Retrieve(codigo_empresa,sle_valor.text,periodo,contador)

dw_distribuidores.Retrieve(codigo_empresa,"C",&
     This.GetItemString(Row,"pais"),&
     This.GetItemString(Row,"provincia"),"S")

cb_subdis.visible = TRUE
f_activar_campo(sle_valor)
end event

type pb_contactos from up_carpeta within w_int_llamadas
integer x = 759
integer y = 164
integer width = 87
integer height = 84
end type

event clicked;call super::clicked;f_activar_campo(sle_valor)
str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=sle_valor.text
OpenWithParm(wi_mant_contactos,lstr_param)

end event

type cb_mapa from commandbutton within w_int_llamadas
integer x = 2235
integer y = 1356
integer width = 594
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Mapa Provincias"
end type

event clicked;
//   p_1.visible=TRUE
open(wi_spain)


end event

type cb_subdis from commandbutton within w_int_llamadas
boolean visible = false
integer x = 27
integer y = 1356
integer width = 594
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Subdistribuidores"
end type

on clicked;If dw_1.GetRow() =0 Then Return
dw_subdistribuidores.visible = TRUE

dw_subdistribuidores.Retrieve(codigo_empresa,'S',&
                              f_pais_contacto(codigo_empresa,sle_valor.text),&                             
                              dw_1.GetItemString(dw_1.GetRow(),"provincia"),'S')

cb_subdis.visible = FALSE
cb_distri.visible = TRUE
IF cb_insertar.enabled= TRUE Then
  dw_1.Setfocus()
ELSE
  f_activar_campo(sle_valor)
END IF



end on

type cb_distri from commandbutton within w_int_llamadas
boolean visible = false
integer x = 27
integer y = 1356
integer width = 594
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Distribuidores"
end type

on clicked;If dw_1.GetRow() =0 Then Return
dw_subdistribuidores.visible = FALSE
dw_distribuidores.visible = TRUE

dw_distribuidores.Retrieve(codigo_empresa,'C',&
                          f_pais_contacto(codigo_empresa,sle_valor.text),&
                          dw_1.GetItemString(dw_1.GetRow(),"provincia"),'S')

cb_subdis.visible = TRUE
cb_distri.visible = FALSE

IF cb_insertar.enabled= TRUE Then
  dw_1.Setfocus()
ELSE
  f_activar_campo(sle_valor)
END IF



end on

type dw_subdistribuidores from datawindow within w_int_llamadas
boolean visible = false
integer x = 27
integer y = 740
integer width = 2839
integer height = 616
boolean titlebar = true
string title = "Subdistribuidores"
string dataobject = "dw_int_llamadas4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=This.GetItemString(Row,"codigo_cliente")
lstr_param.s_argumentos[3]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_distribuidores,lstr_param) 
end event

type p_1 from picturebutton within w_int_llamadas
boolean visible = false
integer x = 9
integer width = 2944
integer height = 1488
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\spain.bmp"
end type

on clicked;This.visible= FALSE
IF cb_insertar.enabled=TRUE THEN
  dw_1.SetFocus()
ELSE
 f_activar_campo(sle_valor)
END IF
end on

type dw_distribuidores from datawindow within w_int_llamadas
integer x = 27
integer y = 744
integer width = 2807
integer height = 608
boolean titlebar = true
string title = "Distribuidores "
string dataobject = "dw_int_llamadas3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]="C"
lstr_param.s_argumentos[3]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clipro,lstr_param) 
end event

type gb_1 from groupbox within w_int_llamadas
integer x = 251
integer y = 604
integer width = 1234
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type


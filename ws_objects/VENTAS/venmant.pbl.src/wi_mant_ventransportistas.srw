$PBExportHeader$wi_mant_ventransportistas.srw
$PBExportComments$Mant. de Agencias y transportistas.
forward
global type wi_mant_ventransportistas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_ventransportistas
end type
type cb_traspaso from commandbutton within wi_mant_ventransportistas
end type
type uo_empresa_destino from u_empresa_destino within wi_mant_ventransportistas
end type
end forward

global type wi_mant_ventransportistas from wi_mvent_con_empresa
integer width = 2912
integer height = 1396
pb_calculadora pb_calculadora
cb_traspaso cb_traspaso
uo_empresa_destino uo_empresa_destino
end type
global wi_mant_ventransportistas wi_mant_ventransportistas

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Transportistas"
	istr_parametros.s_listado        = "report_ventransportistas"
   This.title = istr_parametros.s_titulo_ventana

	cb_traspaso.enabled = false
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      istr_parametros.i_nargumentos=0
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         This.TriggerEvent("ue_recuperar")
      END IF
   END IF


end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
cb_traspaso.visible = TRUE

end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "ventransportista"

cb_traspaso.enabled=true

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
	dw_1.setitem(dw_1.getrow(),"tipo",'A')
end event

on wi_mant_ventransportistas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.cb_traspaso=create cb_traspaso
this.uo_empresa_destino=create uo_empresa_destino
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.cb_traspaso
this.Control[iCurrent+3]=this.uo_empresa_destino
end on

on wi_mant_ventransportistas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.cb_traspaso)
destroy(this.uo_empresa_destino)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
cb_traspaso.visible    = FALSE

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_ventransportistas
integer x = 23
integer y = 360
integer width = 2373
integer height = 756
string dataobject = "dw_ventransportistas"
end type

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param

// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_transportistas"

CHOOSE CASE ls_objeto

CASE 'pb_pais'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)  
CASE 'pb_codpostal'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"codpostal")
   OpenWithParm(wi_mant_codpostales,lstr_param)  
END CHOOSE





end event

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
valor_empresa = TRUE
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "pais"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "provincia"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"'"
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "codpostal"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

on dw_1::itemfocuschanged;call wi_mvent_con_empresa`dw_1::itemfocuschanged;string li_codprov
String li_codpais

CHOOSE CASE dw_1.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"localidad",var_localidad)   
END IF
END CHOOSE


end on

event dw_1::rbuttondown;valor_empresa = TRUE
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "provincia"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "codpostal"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_ventransportistas
integer x = 160
integer y = 220
integer width = 283
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_ventransportistas
integer x = 2423
integer y = 360
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_ventransportistas
integer x = 2423
integer y = 480
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_ventransportistas
integer x = 448
integer y = 208
integer height = 92
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow =  "dw_ayuda_ventransportistas"
ue_titulo     =  "AYUDA SELECCION TRANSPORTISTAS"
ue_filtro     =  ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_ventransportistas
integer x = 2423
integer y = 600
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_ventransportistas
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_ventransportistas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_ventransportistas
integer y = 28
integer width = 2816
end type

type pb_calculadora from u_calculadora within wi_mant_ventransportistas
integer x = 713
integer y = 208
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From ventransportista
 Where  ventransportista.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,ventransportista.codigo)+1)
  Into   :sle_valor.text
  From   ventransportista
  Where  ventransportista.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type cb_traspaso from commandbutton within wi_mant_ventransportistas
boolean visible = false
integer x = 1047
integer y = 216
integer width = 315
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&traspaso"
end type

event clicked;// Visualizar controles selección empresa
//gb_empresa.visible  = true
//uo_empresa.visible  = true
//cb_procesar.visible = true
//cb_cancelar.visible = true
uo_empresa_destino.visible = true

end event

type uo_empresa_destino from u_empresa_destino within wi_mant_ventransportistas
boolean visible = false
integer x = 1381
integer y = 132
integer width = 1349
integer height = 200
integer taborder = 30
boolean bringtotop = true
long backcolor = 79741120
end type

on uo_empresa_destino.destroy
call u_empresa_destino::destroy
end on

event ue_procesar;String empresa_destino,transpor
// variables  para traspaso de datos
String var_codigo,var_nombre,var_cif,var_direccion,var_pais,var_provincia,&
	var_codpostal,var_localidad,var_telefono,var_fax
Dec{0} registros
Boolean actualizar=false
// Comprobación de empresa distinta a la actual
empresa_destino=uo_empresa_destino.uo_empresa.em_codigo.text

if empresa_destino=codigo_empresa then
	f_mensaje ("Advertencia","La empresa destino de la copia no puede ser la actual")
	This.visible=false
	Return
end if
Dec{0} num
Integer resp
transpor = sle_valor.text
var_nombre    = dw_1.GetItemString(1,"nombre")

Select count(*)
into :num
from ventransportista
where 
	empresa = :empresa_destino and
	nombre  = :var_nombre;
if num>0 then
	// Existe un transportista con ese nombre en la otra empresa
	resp=MessageBox ("Advertencia","Existe un transportista con ese nombre en la otra empresa. "+Char(13)+&
				"¿Desea actualizar sus datos?.",Question!,YesNo!,2)
	if resp = 2 then 
		This.visible=false
		Return
	else
		actualizar=true
	end if	
end if

Select count(*)
into :num
from ventransportista
where 
	empresa = :empresa_destino and
	codigo  = :transpor;

if num>0  AND not actualizar then
	// El código del transportista ya existe en la otra empresa. 
	f_mensaje ("Advertencia","El código de este transportista ya existe para la otra empresa. "+Char(13)+&
				"Se le va a aplicar un código distinto.")
	// Seleccionamos el siguiente
	 Select count(*) Into :registros From ventransportista
 	Where  ventransportista.empresa = :empresa_destino;
 	IF registros=0  Then
  		var_codigo="1"
 	ELSE
  		Select max(convert(int,ventransportista.codigo)+1)
  		Into   :var_codigo
  		From   ventransportista
  		Where  ventransportista.empresa = :empresa_destino;
	end if

else
	// Le ponemos el mismo código
	var_codigo = sle_valor.text
end if	


var_cif       = dw_1.GetItemString(1,"cif")
var_direccion = dw_1.GetItemString(1,"direccion")
var_pais      = dw_1.GetItemString(1,"pais")
var_provincia = dw_1.GetItemString(1,"provincia")
var_codpostal = dw_1.GetItemString(1,"codpostal")
var_localidad = dw_1.GetItemString(1,"localidad")
var_telefono  = dw_1.GetItemString(1,"telefono")
var_fax       = dw_1.GetItemString(1,"fax")

if actualizar then
	UPDATE ventransportista
	SET cif = :var_cif, direccion =:var_direccion, pais =:var_pais,
		 provincia= :var_provincia, codpostal=:var_codpostal, 
		 localidad= :var_localidad, telefono=:var_telefono,    
		 fax =:var_fax
	WHERE empresa =:empresa_destino and
			codigo = :var_codigo;
			
	
	
else
	INSERT INTO ventransportista (empresa,codigo,nombre,cif,direccion,
			pais,provincia,codpostal,localidad,telefono,fax)
	VALUES (:empresa_destino, :var_codigo,    :var_nombre,
		 :var_cif,         :var_direccion, :var_pais,
		 :var_provincia,	 :var_codpostal, :var_localidad,
		 :var_telefono,    :var_fax);
end if


end event


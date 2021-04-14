$PBExportHeader$wi_mant_contactos.srw
$PBExportComments$Mantenimientos de contactos.
forward
global type wi_mant_contactos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_contactos
end type
end forward

global type wi_mant_contactos from wi_mvent_con_empresa
integer width = 2971
integer height = 1600
pb_calculadora pb_calculadora
end type
global wi_mant_contactos wi_mant_contactos

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"sexo","M")
   dw_1.setitem(dw_1.getrow(),"activo","S")
   dw_1.SetItem(dw_1.getrow(),"fecha_alta",DateTime(today(),now()))
   dw_1.setitem(dw_1.getrow(),"pais","11")
   dw_1.setitem(dw_1.getrow(),"tipo_llamada","1")

end on

on close;call wi_mvent_con_empresa::close;clave=sle_valor.text
end on

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "mcontactos"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on open;call wi_mvent_con_empresa::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Contactos"
	istr_parametros.s_listado        = "report_contactos"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_contactos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_contactos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contactos
integer x = 18
integer y = 336
integer width = 2450
integer height = 980
string dataobject = "dw_contactos"
end type

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"pais")
f_valores_numericos(dw_1,"provincia")
f_valores_numericos(dw_1,"cod_postal")
f_valores_numericos(dw_1,"tipo_llamada")

end on

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa=TRUE

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
   CASE "cod_postal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   CASE "tipo_llamada"
      bus_datawindow = "dw_ayuda_tiposllamadas"
      bus_titulo = "VENTANA SELECCION TIPOS DE LLAMADAS"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key

 IF bus_campo = "provincia" then
   String prefijo,cod_pais,cod_provincia

   prefijo       = GetItemString(This.GetRow(),"prefijo_provincia")
   cod_pais      = GetItemString(This.GetRow(),"pais")
   cod_provincia = GetItemString(This.GetRow(),"provincia")

   if Trim(prefijo)="" or IsNull(prefijo) then
	      SELECT provincias.prefijo
         INTO :prefijo
         FROM provincias  
         WHERE (provincias.pais      = :cod_pais) AND  
               (provincias.provincia = :cod_provincia) USING SQLCA;
         IF SQLCA.SQLCode<>0 THEN
               prefijo=""
         END IF
         This.SetItem(This.getrow(),"prefijo_provincia",prefijo)   
   END IF
  END IF

END IF

end event

event dw_1::rbuttondown; valor_empresa = TRUE
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
      valor_empresa = FALSE
  CASE "provincia"
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
      valor_empresa = FALSE
  CASE "cod_postal"
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
      valor_empresa = FALSE 
  CASE "tipo_llamada"
      bus_datawindow = "dw_ayuda_tiposllamadas"
      bus_titulo = "VENTANA SELECCION TIPOS DE LLAMADA"
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

on dw_1::itemfocuschanged;call wi_mvent_con_empresa`dw_1::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE dw_1.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'cod_postal')	
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

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param

// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_contactos"

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
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cod_postal")
   OpenWithParm(wi_mant_codpostales,lstr_param)  
CASE 'pb_llamada'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_llamada")
   OpenWithParm(wi_mant_tipollamada,lstr_param)  
END CHOOSE





end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contactos
integer x = 151
integer width = 283
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contactos
integer x = 2491
integer y = 332
integer width = 370
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contactos
integer x = 2491
integer y = 452
integer width = 370
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contactos
integer x = 425
integer width = 389
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow =  "dw_ayuda_contactos"
ue_titulo     =  "AYUDA SELECCION CONTACTOS"
ue_filtro     =  ""
isle_campo    = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contactos
integer x = 2491
integer y = 572
integer width = 370
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contactos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contactos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contactos
integer width = 2857
end type

type pb_calculadora from u_calculadora within wi_mant_contactos
integer x = 823
integer y = 208
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return


 Integer registros,numero
 String  n_contacto,var_empresa

  SELECT mparamcontactos.empresa,mparamcontactos.contador  
    INTO :var_empresa,:registros  
    FROM mparamcontactos  
   WHERE mparamcontactos.empresa = :codigo_empresa   
   ORDER BY mparamcontactos.empresa ASC  ;
   If Sqlca.Sqlcode=100 Then
       INSERT INTO mparamcontactos  
              (empresa,contador)  
       VALUES (:codigo_empresa,:registros );
   END IF
   IF IsNull(registros) Then registros=0
   registros=registros + 1
   n_contacto= String(registros)

   Select count(*) Into :numero From mcontactos
   Where  mcontactos.empresa  = :codigo_empresa
   And    mcontactos.codigo= :n_contacto;
   If IsNull(numero) Then numero=0
   If numero<>0 Then
       Select max(convert(int,mcontactos.codigo)+1)
       Into   :sle_valor.text
       From   mcontactos
       Where  mcontactos.empresa = :codigo_empresa;
       registros= Integer(sle_valor.text)
   End If
   UPDATE mparamcontactos  
   SET contador = :registros  
   WHERE mparamcontactos.empresa = :codigo_empresa;

   sle_valor.text=String(registros)

   dw_1.TriggerEvent("Clicked")
end on


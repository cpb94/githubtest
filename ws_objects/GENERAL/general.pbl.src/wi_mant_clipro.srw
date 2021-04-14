$PBExportHeader$wi_mant_clipro.srw
$PBExportComments$Mantenimientos de Clientes/Proveedores.
forward
global type wi_mant_clipro from wi_mvent_con_empresa
end type
type rb_tercero from radiobutton within wi_mant_clipro
end type
type rb_cliente from radiobutton within wi_mant_clipro
end type
type gb_1 from groupbox within wi_mant_clipro
end type
type rb_proveedor from radiobutton within wi_mant_clipro
end type
type pb_calculadora from u_calculadora within wi_mant_clipro
end type
type st_3 from statictext within wi_mant_clipro
end type
type pb_2 from upb_carpeta within wi_mant_clipro
end type
type gb_2 from groupbox within wi_mant_clipro
end type
type cb_enlace from commandbutton within wi_mant_clipro
end type
end forward

global type wi_mant_clipro from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2926
integer height = 1920
rb_tercero rb_tercero
rb_cliente rb_cliente
gb_1 gb_1
rb_proveedor rb_proveedor
pb_calculadora pb_calculadora
st_3 st_3
pb_2 pb_2
gb_2 gb_2
cb_enlace cb_enlace
end type
global wi_mant_clipro wi_mant_clipro

type variables
	// Tipo Tercero

string ic_tipoter
datawindowchild idwc_nompro
datawindowchild idwc_codpostal
datawindowchild idwc_codpais,idwc_codmoneda
boolean crear_cuenta = false
end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Clientes/Proveedores"
istr_parametros.s_listado        = "report_clipro"


This.title=istr_parametros.s_titulo_ventana

IF trim(ic_tipoter)="" THEN
   ic_tipoter = 'C'				// Damos el valor incial de tipo tercero
   rb_cliente.checked = TRUE
   rb_proveedor.checked = FALSE
   rb_tercero.checked = FALSE
END IF

   
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;
		// Activamos los campos clave añadidos

rb_cliente.enabled     = TRUE
rb_proveedor.enabled   = TRUE
rb_tercero.enabled     = TRUE
pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.SetItem(dw_1.getrow(),"sexo","H")
dw_1.SetItem(dw_1.getrow(),"activo","S")
dw_1.SetItem(dw_1.getrow(),"falta",DateTime(today(),now()))

dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"tipoter",ic_tipoter)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

IF rb_cliente.checked = True Then 
	String cuenta
//	cuenta =  f_compone_cta_cliente(codigo_empresa,f_ejercicio_activo(codigo_empresa),sle_valor.text)
	// Comprueba si existe la cuenta
//	if f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,cuenta)<>"" then
//		dw_1.setitem(dw_1.getrow(),"cuenta",string(f_compone_cta_cliente(codigo_empresa,f_ejercicio_activo(codigo_empresa),sle_valor.text)))
//      f_mensaje("! A t e n c i ó n ","La cuenta contable ya existe, asignar")
//	else	
//   	dw_1.setitem(dw_1.getrow(),"cuenta",string(f_compone_cta_cliente(codigo_empresa,f_ejercicio_activo(codigo_empresa),sle_valor.text)))
		//f_mensaje("! A t e n c i ó n ","La cuenta contable no existe, se debe crear")
//   End if				
End if
	 

end event

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title

 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)

 longitud     =  len(Trim(ic_tipoter))
 criterio[2]  =  trim(ic_tipoter)+space(20-longitud)

 longitud     =  len(Trim(sle_valor.text))
 criterio[3]  =  trim(sle_valor.text)+space(20-longitud)

 seleccion    =  criterio[1]+criterio[2]+criterio[3]

 tabla        = "genter"

 dw_1.Retrieve(codigo_empresa,ic_tipoter,sle_valor.text)
 CALL Super::ue_recuperar



end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;
		// Activamos los campos clave añadidos

rb_cliente.enabled     = FALSE
rb_proveedor.enabled   = FALSE
rb_tercero.enabled     = FALSE
pb_calculadora.visible = FALSE
end on

on wi_mant_clipro.create
int iCurrent
call super::create
this.rb_tercero=create rb_tercero
this.rb_cliente=create rb_cliente
this.gb_1=create gb_1
this.rb_proveedor=create rb_proveedor
this.pb_calculadora=create pb_calculadora
this.st_3=create st_3
this.pb_2=create pb_2
this.gb_2=create gb_2
this.cb_enlace=create cb_enlace
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_tercero
this.Control[iCurrent+2]=this.rb_cliente
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.rb_proveedor
this.Control[iCurrent+5]=this.pb_calculadora
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.pb_2
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.cb_enlace
end on

on wi_mant_clipro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_tercero)
destroy(this.rb_cliente)
destroy(this.gb_1)
destroy(this.rb_proveedor)
destroy(this.pb_calculadora)
destroy(this.st_3)
destroy(this.pb_2)
destroy(this.gb_2)
destroy(this.cb_enlace)
end on

event ue_actualiza_dw;string  cta_cuenta,cta_titulo,var_nomcuenta
STRING  cta_riesgo_cuenta,cta_riesgo_titulo
long    cta_ejercicio
LONG	  cta_riesgo_ejercicio

cta_cuenta = dw_1.GetItemString(dw_1.GetRow(),'cuenta')
cta_titulo = dw_1.GetItemString(dw_1.GetRow(),'razon')
cta_ejercicio = f_ejercicio_activo(codigo_empresa)

cta_riesgo_cuenta = f_compone_cta_riesgo_cliente(codigo_empresa,f_ejercicio_activo(codigo_empresa),sle_valor.text)
cta_riesgo_titulo = "RIESGO "+dw_1.GetItemString(dw_1.GetRow(),'razon')
cta_riesgo_ejercicio = f_ejercicio_activo(codigo_empresa)

if insercion = "S" then
	IF rb_cliente.checked Then 
		var_nomcuenta = f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,cta_cuenta)
		if var_nomcuenta = "" then
			//Creamos la cuenta en el ejercicio activo
			insert into contaplan
			(ejercicio,empresa,cuenta
			,titulo,analitica,tipocta
			,directos,nivel,coste)
			values
			(:cta_ejercicio,:codigo_empresa,:cta_cuenta
			,:cta_titulo,"N","3"
			,"S",5,null);
			
			if sqlca.sqlcode = 0 then 
				if cta_ejercicio <> year(today()) then
					//Creamos la cuenta en el ejercicio actual
					cta_ejercicio = year(today())
					var_nomcuenta = f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,cta_cuenta)
					if var_nomcuenta = "" then				
						insert into contaplan
						(ejercicio,empresa,cuenta
						,titulo,analitica,tipocta
						,directos,nivel,coste)
						values
						(:cta_ejercicio,:codigo_empresa,:cta_cuenta
						,:cta_titulo,"N","3"
						,"S",5,null);
						
						if sqlca.sqlcode <> 0 then 
							rollback;
							messagebox("Atención","Se ha producido un Error al crear la cuenta~n"+sqlca.sqlerrtext)				
						end if
					end if
				end if
			else
				rollback;
				messagebox("Atención","Se ha producido un Error al crear la cuenta~n"+sqlca.sqlerrtext)
			end if
		End if		
		
		var_nomcuenta = f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,cta_riesgo_cuenta)
		if var_nomcuenta = "" then
			//Creamos la cuenta de riesgo en el ejercicio activo
			insert into contaplan
			(ejercicio,empresa,cuenta
			,titulo,analitica,tipocta
			,directos,nivel,coste)
			values
			(:cta_riesgo_ejercicio,:codigo_empresa,:cta_riesgo_cuenta
			,:cta_riesgo_titulo,"N","3"
			,"S",5,null);
			
			if sqlca.sqlcode = 0 then 
				if cta_riesgo_ejercicio <> year(today()) then
					//Creamos la de riesgo cuenta en el ejercicio actual
					cta_riesgo_ejercicio = year(today())
					var_nomcuenta = f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,cta_riesgo_cuenta)
					if var_nomcuenta = "" then				
						insert into contaplan
						(ejercicio,empresa,cuenta
						,titulo,analitica,tipocta
						,directos,nivel,coste)
						values
						(:cta_riesgo_ejercicio,:codigo_empresa,:cta_riesgo_cuenta
						,:cta_riesgo_titulo,"N","3"
						,"S",5,null);
						
						if sqlca.sqlcode <> 0 then 
							rollback;
							messagebox("Atención","Se ha producido un Error al crear la cuenta de riesgo~n"+sqlca.sqlerrtext)				
						end if
					end if
				end if
			else
				rollback;
				messagebox("Atención","Se ha producido un Error al crear la cuenta de riesgo~n"+sqlca.sqlerrtext)
			end if
		End if		
		
	End if
End if

CALL Super::ue_actualiza_dw

end event

event activate;call super::activate;wi_mant_clipro = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_clipro
integer x = 0
integer y = 324
integer width = 2432
integer height = 1056
string dataobject = "dw_genter"
end type

event dw_1::key; valor_empresa = TRUE	
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
   CASE "cod_postal"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   CASE "idioma"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo = "VENTANA SELECCION DE IDIOMAS"
   CASE "moneda"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE DIVISAS"
   CASE "cuenta"
      bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_titulo = "VENTANA SELECCION DE CUENTAS"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key


end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE	
 CHOOSE CASE bus_campo
   CASE "cuenta"
      bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_titulo = "VENTANA SELECCION DE CUENTAS"
	CASE "pais"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
   CASE "provincia"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE "cod_postal"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_codpostales"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   CASE "idioma"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo = "VENTANA SELECCION DE IDIOMAS"
   CASE "moneda"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE DIVISAS"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;String li_codprov
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





STring  pro,cif
Dec nu

if This.Rowcount() = 0 Then Return

cif=  This.Object.cif[1]
pro = sle_valor.text
IF Trim(cif) <> "" Then
	nu = 0
	Select Count(*) Into :nu from genter
	Where   empresa = :codigo_empresa
	And     tipoter = :ic_tipoter
	and     codigo <> :pro
	and     cif   = :cif;
	IF nu <> 0 Then 
		f_mensaje("Control de altas","Este NIF Esta duplicado")
	END IF

END IF
end event

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param


lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_genter"

CHOOSE CASE f_objeto_datawindow(dw_1)

CASE 'pb_pais'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)  
CASE 'pb_codpostal'
   lstr_param.i_nargumentos  = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cod_postal")
   OpenWithParm(wi_mant_codpostales,lstr_param)  
CASE 'pb_idioma'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"idioma")
   OpenWithParm(wi_mant_idiomas,lstr_param)  
CASE 'pb_moneda'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  
END CHOOSE





end event

event dw_1::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(dw_1,"pais")
       f_valores_numericos(dw_1,"provincia")
       f_valores_numericos(dw_1,"idioma")
       f_valores_numericos(dw_1,"moneda")
//---------------------------------------------//
//---------------------------------------------//
end event

event dw_1::itemchanged;string pais,provincia
////Cuenta contable
if dwo.name='provincia' and rb_cliente.checked then
	pais=dw_1.getitemstring(1,"pais")
	provincia=dw_1.getitemstring(1,"provincia")
	if not isnull(pais) and not isnull(provincia) then
		dw_1.SetItem(1,"cuenta",f_compone_cta_cliente(codigo_empresa,f_ejercicio_activo(codigo_empresa),sle_valor.text,pais,data))
	end if
end if
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_clipro
integer x = 1541
integer y = 224
integer width = 288
integer height = 80
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_clipro
integer x = 2464
integer y = 324
integer width = 370
end type

event cb_insertar::clicked;IF cb_Insertar.enabled=TRUE THEN
dw_1.Accepttext()
string  var_pais,var_provincia,var_idioma,var_moneda
Integer contador
String  campo,var_razon,var_cuenta


var_pais      = dw_1.GetItemString(dw_1.GetRow(),'pais')
var_idioma    = dw_1.GetItemString(dw_1.GetRow(),'idioma')	
var_moneda    = dw_1.GetItemString(dw_1.GetRow(),'moneda')	
var_razon     = dw_1.GetItemString(dw_1.GetRow(),'razon')	
var_cuenta    = dw_1.GetItemString(dw_1.GetRow(),'cuenta')	
if insercion = "S" then
   string var_nomcuenta
	var_nomcuenta = f_nombre_contaplan(f_ejercicio_activo(codigo_empresa),codigo_empresa,var_cuenta)
	if var_nomcuenta<>"" then
      f_mensaje("! A t e n c i ó n ","La cuenta contable pertenece a "+var_nomcuenta)
		//campo="cuenta"		
   End if		
End if

IF IsNull(var_idioma) or Trim(String(var_idioma))="" THEN  campo="idioma"
IF IsNull(var_moneda) or Trim(String(var_moneda))="" THEN  campo="moneda"
IF IsNull(var_pais) or Trim(String(var_pais))="" THEN  campo="pais"

 IF Trim(campo)<>"" THEN
  MessageBox(campo+": Campo obligatorio","Introducir el campo ",Exclamation!, OK!,1)
  dw_1.SetColumn(campo)
  dw_1.setRow(dw_1.getRow())
  dw_1.setfocus()
  Return
 END IF

END IF



CALL Super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_clipro
integer x = 2464
integer y = 432
integer width = 370
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_clipro
integer x = 1847
integer y = 220
integer width = 462
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES/PROVEEDORES"
IF ic_tipoter= "C" Then	ue_datawindow = "dw_ayuda_clientes"
IF ic_tipoter= "P" Then	ue_datawindow = "dw_ayuda_proveedores"
IF ic_tipoter= "T" Then	ue_datawindow = "dw_ayuda_terceros"



isle_campo    = this

IF istr_parametros.i_nargumentos>1 THEN
	
	  ic_tipoter=istr_parametros.s_argumentos[2]
     sle_valor.text=istr_parametros.s_argumentos[3]
 	  istr_parametros.i_nargumentos=0
     
	  ue_filtro     = "tipoter = '" + ic_tipoter + "'"
	  
	  CHOOSE case ic_tipoter
            case "C"
               rb_cliente.checked = TRUE
					rb_proveedor.checked = FALSE
					rb_tercero.checked = FALSE
				case "P"	 
               rb_cliente.checked = FALSE
					rb_proveedor.checked = TRUE
					rb_tercero.checked = FALSE
		      case "T"
               rb_cliente.checked = FALSE
					rb_proveedor.checked = FALSE
					rb_tercero.checked = TRUE
     End CHOOSE
     
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
			Parent.TriggerEvent("ue_recuperar")
     END IF  
  
END IF

Choose Case ic_tipoter
	case "C","T"
		 gb_2.visible = true
		 pb_2.visible = True
		 sT_3.visible = True
   case "P"
		 gb_2.visible = true
		 pb_2.visible = True
		 sT_3.visible = True
   case else
   	 gb_2.visible = False
	    pb_2.visible = False
       sT_3.visible = False
End Choose
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_clipro
integer x = 2464
integer width = 370
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_clipro
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_clipro
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_clipro
integer width = 2766
end type

type rb_tercero from radiobutton within wi_mant_clipro
integer x = 846
integer y = 200
integer width = 384
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Tercero"
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

IF ic_tipoter <> 'T' THEN 
	dw_1.Reset()
	cb_enlace.visible = false
end if

ic_tipoter = 'T'
istr_parametros.s_listado        = "report_clipro3"

f_activar_campo(sle_valor)		// Despues de Activar pasar al campo clave.

end event

type rb_cliente from radiobutton within wi_mant_clipro
integer x = 64
integer y = 204
integer width = 384
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Cliente"
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

IF ic_tipoter <> 'C' THEN 
	dw_1.Reset()
	cb_enlace.visible = true
	cb_enlace.text = "Datos Ventas"
end if

ic_tipoter = 'C'
istr_parametros.s_listado        = "report_clipro"

f_activar_campo(sle_valor)		// Despues de Activar pasar al campo clave.

end event

type gb_1 from groupbox within wi_mant_clipro
integer x = 18
integer y = 160
integer width = 1257
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type rb_proveedor from radiobutton within wi_mant_clipro
integer x = 416
integer y = 204
integer width = 384
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Proveedor"
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

IF ic_tipoter <> 'P' THEN 
	dw_1.Reset()
	cb_enlace.visible = true
	cb_enlace.text = "Datos Compras"
end if

ic_tipoter = 'P'
istr_parametros.s_listado        = "report_clipro2"

f_activar_campo(sle_valor)		// Despues de Activar pasar al campo clave.
end event

type pb_calculadora from u_calculadora within wi_mant_clipro
integer x = 2322
integer y = 212
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return

Integer registros

Select count(*) Into :registros From genter
Where  genter.empresa       = :codigo_empresa
and    genter.tipoter       = :ic_tipoter;

IF registros=0 THEN
 sle_valor.text="1" 
ELSE
 Select max(convert(int,genter.codigo)+1)
 Into   :sle_valor.text
 From   genter
 Where  genter.empresa  = :codigo_empresa
 and    genter.tipoter  = :ic_tipoter;

END IF
dw_1.TriggerEvent("Clicked")
end on

type st_3 from statictext within wi_mant_clipro
boolean visible = false
integer x = 2578
integer y = 760
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Contactos"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_2 from upb_carpeta within wi_mant_clipro
event clicked pbm_bnclicked
boolean visible = false
integer x = 2469
integer y = 748
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
end type

event clicked;call super::clicked;str_parametros lstr_param
lstr_param.i_nargumentos=3
lstr_param.s_argumentos[2]= sle_valor.text
lstr_param.s_argumentos[3]= ic_tipoter
f_activar_campo(sle_valor)
OpenWithParm(wi_mant_telefonos,lstr_param) 

end event

type gb_2 from groupbox within wi_mant_clipro
boolean visible = false
integer x = 2450
integer y = 700
integer width = 384
integer height = 152
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_enlace from commandbutton within wi_mant_clipro
integer x = 2464
integer y = 1040
integer width = 370
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Datos Ventas"
end type

event clicked;str_parametros lstr_param
if not(cb_insertar.enabled) then
	if rb_cliente.checked then
		lstr_param.i_nargumentos   = 2
		lstr_param.s_argumentos[2] = sle_valor.text
		OpenWithParm(wi_mant_clientes2,lstr_param)  
	else
		if rb_proveedor.checked then
			lstr_param.i_nargumentos   = 2
			lstr_param.s_argumentos[2] = sle_valor.text
			OpenWithParm(w_mant_comproveedores,lstr_param)  
		end if	
	end if
end if
end event


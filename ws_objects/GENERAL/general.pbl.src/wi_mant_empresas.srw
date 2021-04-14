$PBExportHeader$wi_mant_empresas.srw
$PBExportComments$Mantenimientos de empresas.
forward
global type wi_mant_empresas from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within wi_mant_empresas
end type
type dp_fecha_calculo_coste from datepicker within wi_mant_empresas
end type
type cb_1 from commandbutton within wi_mant_empresas
end type
type gb_1 from groupbox within wi_mant_empresas
end type
end forward

global type wi_mant_empresas from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2770
integer height = 2092
pb_calculadora pb_calculadora
dp_fecha_calculo_coste dp_fecha_calculo_coste
cb_1 cb_1
gb_1 gb_1
end type
global wi_mant_empresas wi_mant_empresas

type variables



end variables

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Empresas"
istr_parametros.s_listado        = "report_empresas"
This.title=istr_parametros.s_titulo_ventana


dp_fecha_calculo_coste.value =  datetime (today())

 // Si recibo el codigo lo visualizo

IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
     IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	dw_1.Retrieve(sle_valor.text)
     END IF
END IF
end event

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;  dw_1.setitem(dw_1.getrow(),"empresa",sle_valor.text)
end on

on ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       = This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "empresas"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end on

on wi_mant_empresas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dp_fecha_calculo_coste=create dp_fecha_calculo_coste
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dp_fecha_calculo_coste
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
end on

on wi_mant_empresas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dp_fecha_calculo_coste)
destroy(this.cb_1)
destroy(this.gb_1)
end on

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_empresas
integer x = 32
integer y = 176
integer width = 2665
integer height = 1580
string dataobject = "dw_empresas"
borderstyle borderstyle = stylebox!
end type

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
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' AND "
		bus_filtro     = bus_filtro + " provincia = '"+GetItemString(This.GetRow(),"provincia")+"'"
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   CASE "idioma"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo = "VENTANA SELECCION DE IDIOMAS"
   CASE "empr_compra_merc"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_empresas"
		bus_filtro = "empresa <> '" + sle_valor.text	+ "'"	
		bus_titulo = "VENTANA SELECCION DE EMPRESAS"
   CASE "proveedor_merc"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_proveedores"		
   CASE "cliente_merc"		 
		bus_titulo     = "AYUDA SELECCION CLIENTES"
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = "" 			 

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

event dw_1::itemfocuschanged;call super::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE dw_1.GetColumnName()
CASE "ciudad"
  String var_provincia,var_pais
  String     var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostal')	
  var_localidad = This.GetItemString(This.GetRow(),'ciudad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"ciudad",var_localidad)   
END IF
END CHOOSE


end event

on dw_1::valores_numericos;call wi_mant_ventanas`dw_1::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(dw_1,"pais")
       f_valores_numericos(dw_1,"provincia")
       f_valores_numericos(dw_1,"idioma")
//---------------------------------------------//
//---------------------------------------------//
end on

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)  

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_empresas"

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
CASE 'pb_idioma'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"idioma")
   OpenWithParm(wi_mant_idiomas,lstr_param)  
CASE 'pb_empresa'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"empr_compra_merc")
   OpenWithParm(wi_mant_empresas,lstr_param)  

END CHOOSE





end event

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
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' AND "
      bus_filtro     = bus_filtro + " provincia = '"+GetItemString(This.GetRow(),"provincia")+"'"		
      bus_titulo = "VENTANA SELECCION DE CODIGOS POSTALES"
   CASE "idioma"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_idiomas"
		bus_titulo = "VENTANA SELECCION DE IDIOMAS"
   CASE "empr_compra_merc"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_empresas"
		bus_filtro = "empresa <> '" + sle_valor.text	+ "'"	
		bus_titulo = "VENTANA SELECCION DE EMPRESAS"
   CASE "proveedor_merc"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_proveedores"		
   CASE "cliente_merc"		 
		bus_titulo     = "AYUDA SELECCION CLIENTES"
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = "" 			
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_empresas
integer x = 146
integer y = 44
integer height = 88
string text = "Empresa"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_empresas
integer x = 1669
integer y = 48
integer width = 338
integer height = 80
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_empresas
integer x = 2007
integer y = 48
integer width = 338
integer height = 80
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_empresas
integer x = 503
integer y = 44
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION DE EMPRESAS"
ue_datawindow     = "dw_ayuda_empresas"
ue_filtro         = "" 
valor_empresa = FALSE
isle_campo        = This  
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_empresas
integer x = 2345
integer y = 48
integer width = 338
integer height = 80
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_empresas
end type

type pb_calculadora from u_calculadora within wi_mant_empresas
integer x = 786
integer y = 40
integer taborder = 0
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros
Select count(*) Into :registros From empresas;
IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,empresas.empresa)+1) 
   Into   :sle_valor.text
   From   empresas;
END IF
dw_1.TriggerEvent("Clicked")
end on

type dp_fecha_calculo_coste from datepicker within wi_mant_empresas
integer x = 87
integer y = 1784
integer width = 512
integer height = 92
integer taborder = 20
boolean bringtotop = true
boolean border = true
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2019-06-27"), Time("13:32:18.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_1 from commandbutton within wi_mant_empresas
integer x = 608
integer y = 1776
integer width = 745
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Distribución Coste Estr."
end type

event clicked;datastore datos
string sel
string lsCliente, lsFechaHasta, lsFechaDesde
string lsModify, lsResultado
long i, anyo
dec {4} ldPorcentaje, ldCoste_estructura, ldCosteCliente

//if 	MessageBox("Aviso ", "Desea Continuar con el recálculo de coste de estructura") then
//end if

if dw_1.RowCount() > 0 then

	update venclientes
	set coste_anyo = 0
	where empresa = :codigo_empresa
	using SQLCA;
	
	IF SQLCA.SQLCode = -1 THEN         
		MessageBox("Error al inicalizar a 0 el coste de estructura de los clientes. "+lsCliente, SQLCA.SQLErrText)
		ROLLBACK USING SQLCA;
	ELSE
		COMMIT USING SQLCA;
	END IF

//	LsFechaHasta = string (dp_fecha_calculo_coste.value, "dd-mm-yyyy")
	LsFechaHasta = string (dp_fecha_calculo_coste.value, "dd-mm-yyyy")

	anyo = year(today())
	LsFechaDesde = string (Datetime(Date("1/1/"+string(anyo))))
	ldCoste_estructura = dw_1.object.coste_estructura[dw_1.GetRow()]


	sel = " SELECT venlifac.cliente "+&
			"   , sum(venlifac.neto / isnull(venlifac.cambio , 1) ) AS ventas_actual  "+&
			" FROM venlifac  "+&
			" INNER JOIN articulos ON  "+&
			" venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo  "+&
			" WHERE venlifac.empresa  = '1' "+&
			" AND articulos.promocion <>  'S' "+&
			" AND venlifac.ffactura >= '"+LsFechaDesde+"' "+&
			" AND venlifac.ffactura <= '"+LsFechaHasta+"' "+&
			" GROUP BY venlifac.cliente  "
			 
			 
	f_cargar_cursor_transaccion(SQLCA, datos, sel)
	
	lsModify = "create compute(band=detail alignment='0' expression='percent(  ventas_actual  for all)' visible=~"0~" border='0' color='16777215' x='19' y='288' height='57' width='563' format='[general]'  name=porcentaje  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )"
	lsResultado=datos.modify(lsModify)
	
	
	for i = 1 to datos.RowCount()
		ldPorcentaje = datos.object.porcentaje[i]
		ldCosteCliente = ldPorcentaje * ldCoste_estructura
		lsCliente = datos.object.venlifac_cliente[i]
		
		update venclientes 
		set coste_anyo = :ldCosteCliente
		where empresa = :codigo_empresa
		and codigo = :lsCliente
		using SQLCA;
		
		IF SQLCA.SQLCode = -1 THEN         
			MessageBox("SQL error (Cliente: "+lsCliente, SQLCA.SQLErrText)
 			ROLLBACK USING SQLCA;
		ELSE
			COMMIT USING SQLCA;
		END IF
		f_mensaje_proceso ( "Calculando ...",i, datos.RowCount() ) 		
	next
end if
end event

type gb_1 from groupbox within wi_mant_empresas
integer x = 1655
integer y = 16
integer width = 1042
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type


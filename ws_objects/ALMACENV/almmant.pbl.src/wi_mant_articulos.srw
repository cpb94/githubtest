$PBExportHeader$wi_mant_articulos.srw
forward
global type wi_mant_articulos from wi_mvent_con_empresa
end type
type dw_proceso from datawindow within wi_mant_articulos
end type
type dw_pallets from datawindow within wi_mant_articulos
end type
type dw_calidades from datawindow within wi_mant_articulos
end type
type st_4 from statictext within wi_mant_articulos
end type
type gb_1 from groupbox within wi_mant_articulos
end type
type dw_cajas from datawindow within wi_mant_articulos
end type
type dw_2 from datawindow within wi_mant_articulos
end type
type cb_1 from commandbutton within wi_mant_articulos
end type
type pb_calculadora from u_calculadora within wi_mant_articulos
end type
end forward

global type wi_mant_articulos from wi_mvent_con_empresa
integer x = 0
integer y = 8
integer width = 3136
integer height = 1960
dw_proceso dw_proceso
dw_pallets dw_pallets
dw_calidades dw_calidades
st_4 st_4
gb_1 gb_1
dw_cajas dw_cajas
dw_2 dw_2
cb_1 cb_1
pb_calculadora pb_calculadora
end type
global wi_mant_articulos wi_mant_articulos

type variables
String familia,formato,modelo,subfamilia,subformato
u_pipe i_upipe

end variables

forward prototypes
public subroutine f_borrar_calidades ()
public subroutine grabar_calidades (string codemp, string codformato, string codarticulo)
public subroutine f_borrar_cajas ()
public subroutine f_cambi_fam ()
public subroutine f_cambi_tono ()
end prototypes

public subroutine f_borrar_calidades ();Integer x1,registros
String var_empresa,var_articulo,var_calidad
registros = dw_calidades.RowCount()
IF registros=0 Then return
For x1= 1 To registros
   var_empresa   = dw_calidades.GetItemString(x1,"empresa")
   var_articulo  = dw_calidades.GetItemString(x1,"articulo")
   var_calidad   = dw_calidades.GetItemString(x1,"calidad")
   DELETE FROM almartcal  
   WHERE ( almartcal.empresa = :var_empresa ) AND  
         ( almartcal.articulo = :var_articulo ) AND  
         ( almartcal.calidad = :var_calidad )USING SQLCA;


Next
end subroutine

public subroutine grabar_calidades (string codemp, string codformato, string codarticulo);// Graba el mapa de calidades por formato en el mapa de calidades por articulo
integer li_opcion,bien,registros
String cal_empresa,cal_formato,cal_calidad,art_empresa,art_calidad
decimal{4}  cal_precioventa,art_precio
datetime    cal_fechaalta,art_fecha_alta
string      art_articulo,fin
integer cont

dw_proceso.SetTransObject(SQLCA)

registros=dw_proceso.Retrieve(codigo_empresa,codformato)

IF registros=0 Then Return
FOR cont= 1 To registros
 cal_empresa     = dw_proceso.GetItemString(cont,"empresa")
 cal_formato     = dw_proceso.GetItemString(cont,"formato")
 cal_calidad     = dw_proceso.GetItemString(cont,"calidad")
 cal_precioventa = dw_proceso.GetItemDecimal(cont,"precioventa")
 cal_fechaalta   = Datetime(today(),now())

SELECT almartcal.empresa,almartcal.articulo,almartcal.calidad,   
       almartcal.precio,almartcal.fecha_alta
INTO   :art_empresa,:art_articulo,:art_calidad,:art_precio,:art_fecha_alta  
FROM   almartcal  
WHERE (almartcal.empresa  = :cal_empresa ) AND  
      (almartcal.articulo = :codarticulo ) AND  
      (almartcal.calidad  = :cal_calidad )   
ORDER BY almartcal.empresa ASC,almartcal.articulo ASC,
         almartcal.calidad ASC;
   IF SQLCA.SQLCode=0 THEN
        li_opcion = MessageBox("Existen Calidades Por Articulo", &
			                      "Refrescar la Calidad Según Formato", &
               						Question!, YesNo!, 2)
         IF li_opcion=1 THEN
            DELETE FROM almartcal  
            WHERE (almartcal.empresa  = :codemp ) AND  
            (almartcal.articulo = :codarticulo ) AND  
            (almartcal.calidad  = :cal_calidad ) 
            USING SQLCA;
           IF SQLCA.SQLCode<>0 THEN     bien=1
         END IF
     ELSE
        li_opcion=1
     END IF
    If li_opcion=1 THEN
     INSERT INTO almartcal  
         ( empresa,articulo,calidad,precio,fecha_alta )  
  VALUES ( :cal_empresa,:codarticulo,:cal_calidad,   
           :cal_precioventa,:cal_fechaalta ) 
           USING SQLCA;
           IF SQLCA.SQLCode<>0 THEN  bien=1
END IF                                     
NEXT

IF bien=1 THEN
   ROLLBACK USING SQLCA;
   MessageBox("Problemas en la transaccion", &
    			  "No se puede Grabar El mapa de Calidades", &
					Exclamation!, Ok!, 2)
ELSE
   COMMIT USING SQLCA;
END IF

end subroutine

public subroutine f_borrar_cajas ();Integer x1,registros
String var_empresa,var_articulo,var_caja
registros = dw_cajas.RowCount()
IF registros=0 Then return
For x1= 1 To registros
   var_empresa   = dw_cajas.GetItemString(x1,"empresa")
   var_articulo  = dw_cajas.GetItemString(x1,"articulo")
   var_caja   = dw_cajas.GetItemString(x1,"caja")
   DELETE FROM almartcajas  
   WHERE ( almartcajas.empresa = :var_empresa ) AND  
         ( almartcajas.articulo = :var_articulo ) AND  
         ( almartcajas.caja = :var_caja )USING SQLCA;


Next
end subroutine

public subroutine f_cambi_fam ();Constant string fam_ant = "1", fam_nue = "2", prin_nue = "02"
String sel, art, cod_nue
Datastore dd
Integer reg, registros
Boolean bien = true

sel = " SELECT familia, codigo FROM articulos "+&
		" WHERE  articulos.codigo in ('0100301660','0100301661','0100301662','0100301663','0100301664') and articulos.empresa='1'"

//dd = f_cargar_cursor (sel)
f_Cargar_cursor_nuevo(sel, dd)


registros = dd.RowCount()
for reg = 1 to registros
	art = dd.GetItemString(reg,"codigo")
	cod_nue = prin_nue + Mid(art,3)

	f_mensaje("art "+art,"nue "+cod_nue)
	UPDATE ARTICULOS
	   SET familia = :fam_nue, codigo = :cod_nue
  	 WHERE articulos.codigo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "articulos. Error: "+sqlca.sqlerrtext)
	 end if
	 
	UPDATE almartcajas
	   SET articulo = :cod_nue
	 WHERE almartcajas.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "almartcajas. Error: "+sqlca.sqlerrtext)
	 end if

	UPDATE almartcal
	   SET articulo = :cod_nue
	 WHERE almartcal.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "almartcal. Error: "+sqlca.sqlerrtext)
	 end if

	UPDATE almartpallet
	   SET articulo = :cod_nue
	 WHERE almartpallet.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "almartpallet. Error: "+sqlca.sqlerrtext)
	 end if
	 
 	UPDATE palarticulo
	   SET articulo = :cod_nue
	 WHERE palarticulo.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "palarticulo. Error: "+sqlca.sqlerrtext)
	 end if

	UPDATE vendtoartcli
	   SET articulo = :cod_nue, familia = :fam_nue
	 WHERE vendtoartcli.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "vendtoartcli. Error: "+sqlca.sqlerrtext)
	 end if

	UPDATE almlinubica
	   SET articulo = :cod_nue, familia = :fam_nue
	 WHERE almlinubica.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "almlinubica. Error: "+sqlca.sqlerrtext)
	 end if

	UPDATE almlinubicahis
	   SET articulo = :cod_nue, familia = :fam_nue
	 WHERE almlinubicahis.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "almlinubicahis. Error: "+sqlca.sqlerrtext)
	 end if
	 
	UPDATE almmovhis
	   SET articulo = :cod_nue, familia = :fam_nue
	 WHERE almmovhis.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "almmovhis. Error: "+sqlca.sqlerrtext)
	 end if
	 
	UPDATE venlintarifas
	   SET articulo = :cod_nue, familia = :fam_nue
	 WHERE venlintarifas.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "venlintarifas. Error: "+sqlca.sqlerrtext)
	 end if

	UPDATE venlialb
	   SET articulo = :cod_nue, familia = :fam_nue
	 WHERE venlialb.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "venlialb. Error: "+sqlca.sqlerrtext)
	 end if

	UPDATE venlifac
	   SET articulo = :cod_nue, familia = :fam_nue
	 WHERE venlifac.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "venlifac. Error: "+sqlca.sqlerrtext)
	 end if

	UPDATE venliped
	   SET articulo = :cod_nue, familia = :fam_nue
	 WHERE venliped.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "venliped. Error: "+sqlca.sqlerrtext)
	 end if

	UPDATE venliproformas
	   SET articulo = :cod_nue, familia = :fam_nue
	 WHERE venliproformas.articulo = :art
	 USING sqlca;
	 if sqlca.sqlcode <> 0 then
		bien =false
		f_mensaje("error en art " + art, "venliproformas. Error: "+sqlca.sqlerrtext)
	 end if

next

if bien then 
	f_mensaje ("","bien")
	COMMIT using sqlca;
else
	f_mensaje ("","mal")
	ROLLBACK using sqlca;
end if

destroy dd
end subroutine

public subroutine f_cambi_tono ();dec{0} reg, registros,v_anyo,v_fact,v_lin
string sel,v_emp,v_tono
datastore dd

sel = " select empresa, anyo,factura,linea,tonochar "+&
  		" from venlifac "
		  
//dd = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dd)

registros = dd.rowcount()

for reg = 1 to registros
	v_emp  = dd.GetItemString(reg,"empresa")
	v_anyo = dd.GetItemNumber(reg,"anyo")
	v_fact = dd.GetItemNumber(reg,"factura")
	v_lin  = dd.GetItemNumber(reg,"linea")	
	v_tono = dd.GetItemString(reg,"tonochar")
	v_tono = Trim(v_tono)
	update venlifac set tonochar = :v_tono
	where venlifac.empresa = :v_emp
	  and venlifac.anyo    = :v_anyo
	  and venlifac.factura = :v_fact
	  and venlifac.linea   = :v_lin;
   if sqlca.sqlcode=0 then
		
		 commit;
	else
		f_mensaje("","mal")
		rollback;
	end if
	
next

destroy dd
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Articulos"
istr_parametros.s_listado        = "report_articulos"
This.title  =  istr_parametros.s_titulo_ventana

dw_proceso.SetTransObject(SQLCA)


dw_calidades.SetTransObject(SQLCA)
dw_pallets.SetTransObject(SQLCA)
dw_cajas.SetTransObject(SQLCA)

IF istr_parametros.i_nargumentos>1 THEN
    sle_valor.text=istr_parametros.s_argumentos[2]
    f_no_nulo(sle_valor)
    This.TriggerEvent("ue_recuperar")
END IF

f_mascara_columna(dw_1,"pesopieza","###.000")
f_mascara_columna(dw_1,"piezascaja","###0")
f_mascara_columna(dw_1,"pesocaja","###.00")
f_mascara_columna(dw_1,"metroslcaja","###.00")
f_mascara_columna(dw_1,"metroscaja","###.00")
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
st_4.visible = TRUE

end event

event ue_inserta_fila;call super::ue_inserta_fila;Dec{2} var_precio_coste,var_piezas_caja,var_metros,var_metrosl
Dec{3} var_peso_envase,var_peso

String  var_empresa,var_formato,tono,calibre

   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"activo","S")
   dw_1.SetItem(dw_1.GetRow(),"fecha_alta",today())
/*   familia    = String(Integer(Mid(sle_valor.text,1,2)))
	if isnumber(Mid(sle_valor.text,3,2)) then
		subfamilia = String(Integer(Mid(sle_valor.text,3,2)))
	else
		subfamilia=Mid(sle_valor.text,3,2)
	end if
   formato    = String(Integer(Mid(sle_valor.text,5,2)))
	subformato = String(Integer(Mid(sle_valor.text,7,2)))
	modelo     = String(Integer(Mid(sle_valor.text,9,5)))*/
	Select tono,calibre Into :tono,:calibre From familias
	Where empresa = :codigo_empresa
	And   codigo  = :familia;
   dw_1.setitem(dw_1.getrow(),"tono",tono)
   dw_1.setitem(dw_1.getrow(),"calibre",calibre)

SELECT    formatos.empresa,formatos.codigo,formatos.preciocoste,formatos.pesopieza  ,formatos.piezascaja   ,formatos.pesoenvase,formatos.metroscaja,formatos.metroslcaja
INTO      :var_empresa,:var_formato,:var_precio_coste ,:var_peso,:var_piezas_caja,:var_peso_envase,:var_metros,:var_metrosl
FROM      formatos  
WHERE    (formatos.empresa = :codigo_empresa )
AND      (formatos.codigo = :formato )   
ORDER BY formatos.empresa ASC,formatos.codigo ASC;


   dw_1.setitem(dw_1.getrow(),"precio_coste",var_precio_coste)
   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"familia",familia)
   dw_1.setitem(dw_1.getrow(),"formato",formato)
   dw_1.setitem(dw_1.getrow(),"subfamilia",subfamilia)
   dw_1.setitem(dw_1.getrow(),"subformato",subformato)	
	dw_1.setitem(dw_1.getrow(),"modelo",modelo)
	dw_1.setitem(dw_1.getrow(),"pesopieza",var_peso)
	dw_1.setitem(dw_1.getrow(),"pesoenvase",var_peso_envase)
	dw_1.setitem(dw_1.getrow(),"metroscaja",var_metros)
	dw_1.setitem(dw_1.getrow(),"metroslcaja",var_metrosl)
	dw_1.setitem(dw_1.getrow(),"piezascaja",var_piezas_caja)
   dw_1.setitem(dw_1.getrow(),"decorado",f_decorado_familia(codigo_empresa,familia)) 
   dw_1.setitem(dw_1.getrow(),"sector",f_sector_familia(codigo_empresa,familia)) 
	dw_1.setitem(dw_1.getrow(),"compras","N") 

   grabar_calidades(codigo_empresa,formato,sle_valor.text)

   dw_calidades.Retrieve(codigo_empresa,sle_valor.text)
// dw_pallets.Retrieve(codigo_empresa,formato,sle_valor.text)
//	dw_cajas.Retrieve(codigo_empresa,sle_valor.text)
   


end event

event ue_recuperar;integer registros,longitudes
String codigo

// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud    =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "articulos"

registros=dw_1.Retrieve(codigo_empresa,sle_valor.Text)

//Refrescamos las calidades por articulo.
dw_pallets.visible   = TRUE
dw_calidades.visible = TRUE
dw_cajas.visible     = TRUE

// If registros=0 THEN
//    codigo= Mid(sle_valor.text,3,3)
//Else
//   codigo=dw_1.getitemString(dw_1.getrow(),"formato")
//End if

dw_pallets.Retrieve(codigo_empresa,sle_valor.text)
dw_calidades.Retrieve(codigo_empresa,sle_valor.text)
dw_cajas.Retrieve(codigo_empresa,sle_valor.text)


// Control codigo articulo
   
//	Integer bien
//   String valor
//   bien=0
//
//   longitudes=len(Trim(sle_valor.text))
//   IF longitudes<>13 THEN  bien=1
//	
//   familia = String(Integer(Mid(sle_valor.text,1,2)))
//   valor=f_nombre_familia(codigo_empresa,familia)
//   If Trim(valor)="" THEN  bien=1
//
//	if isnumber(Mid(sle_valor.text,3,2)) then
//	   subfamilia = String(Integer(Mid(sle_valor.text,3,2)))
//	else
//		subfamilia=Mid(sle_valor.text,3,2)
//	end if
//   valor=f_nombre_subfamilia(codigo_empresa,subfamilia)
//   If Trim(valor)="" THEN  bien=1	
//	
//   formato = String(Integer(Mid(sle_valor.text,5,2)))
//   valor=f_nombre_formato(codigo_empresa,formato)
//	If Trim(valor)="" THEN  bien=1	
//	
//   subformato = String(Integer(Mid(sle_valor.text,7,2)))
//   valor=f_nombre_subformato(codigo_empresa,subformato)
//   If Trim(valor)="" THEN  bien=1	
//	
//  
//   if bien=1 then
//		  f_activar_campo(sle_valor)
//		  return
//	End if	  
   
	
	i_upipe = CREATE u_pipe
	
	CALL Super::ue_recuperar
	

end event

on wi_mant_articulos.create
int iCurrent
call super::create
this.dw_proceso=create dw_proceso
this.dw_pallets=create dw_pallets
this.dw_calidades=create dw_calidades
this.st_4=create st_4
this.gb_1=create gb_1
this.dw_cajas=create dw_cajas
this.dw_2=create dw_2
this.cb_1=create cb_1
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_proceso
this.Control[iCurrent+2]=this.dw_pallets
this.Control[iCurrent+3]=this.dw_calidades
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.dw_cajas
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.pb_calculadora
end on

on wi_mant_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_proceso)
destroy(this.dw_pallets)
destroy(this.dw_calidades)
destroy(this.st_4)
destroy(this.gb_1)
destroy(this.dw_cajas)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.pb_calculadora)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
st_4.visible = FALSE

end event

event ue_borra_fila;call super::ue_borra_fila;f_borrar_calidades()
f_borrar_cajas()
end event

event ue_f6;call super::ue_f6;IF pb_calculadora.visible = FALSE Then Return
pb_calculadora.TriggerEvent(Clicked!)
end event

event activate;call super::activate;wi_mant_articulos = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_articulos
integer x = 18
integer y = 268
integer width = 2825
integer height = 1168
string dataobject = "dw_articulos"
end type

event dw_1::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "unidad"
		valor_empresa = FALSE
      bus_titulo     = "VENTANA SELECCION DE TIPO DE UNIDAD "
 		bus_datawindow = "dw_ayuda_unidades"
	   valor_empresa = FALSE
   CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_proveedores_sector"
  	CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE CLIENTES"		
   CASE "cuenta_contable"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio ='" + String(f_ejercicio_activo(codigo_empresa)) +"'"
	CASE "empleado"
      bus_titulo     = "VENTANA SELECCION DE EMPLEADOS"
     	bus_datawindow = "dw_ayuda_empleados"
      bus_filtro     = "" 
	CASE "uso"
      bus_titulo     = "VENTANA SELECCION DE USOS"
     	bus_datawindow = "dw_ayuda_almusos"
      bus_filtro     = "" 				
	CASE "estilo"
      bus_titulo     = "VENTANA SELECCION DE ESTILOS"
     	bus_datawindow = "dw_ayuda_almestilos"
      bus_filtro     = "" 						
	CASE "coleccion"
      bus_titulo     = "VENTANA SELECCION DE COLECCIONES"
     	bus_datawindow = "dw_ayuda_almcolecciones"
      bus_filtro     = "" 								
	CASE "color"
      bus_titulo     = "VENTANA SELECCION DE COLOR"
     	bus_datawindow = "dw_ayuda_almcolores"
      bus_filtro     = "" 												
	CASE "familia"
      bus_titulo     = "VENTANA SELECCION DE FAMILIAS"
     	bus_datawindow = "dw_ayuda_familias"
      bus_filtro     = "" 										
	CASE "subfamilia"
      bus_titulo     = "VENTANA SELECCION DE SUBFAMILIAS"
     	bus_datawindow = "dw_ayuda_subfamilias"
      bus_filtro     = "" 										
	CASE "formato"
      bus_titulo     = "VENTANA SELECCION DE FORMATOS"
     	bus_datawindow = "dw_ayuda_formatos"
      bus_filtro     = "" 										
	CASE "subformato"
      bus_titulo     = "VENTANA SELECCION DE SUBFORMATOS"
     	bus_datawindow = "dw_ayuda_subformatos"
      bus_filtro     = "" 														
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event valores_numericos;f_valores_numericos(dw_1,"unidad")
f_valores_numericos(dw_1,"proveedor")
f_valores_numericos(dw_1,"cuenta_contable")
end event

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE f_objeto_datawindow(dw_1)
CASE 'pb_unidad'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"unidad")
   OpenWithParm(wi_mant_unidades,lstr_param)  

CASE 'pb_proveedor'
	lstr_param.s_argumentos[2]="P"
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"proveedor")
   OpenWithParm(wi_mant_clipro,lstr_param)  
CASE 'pb_cliente'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"cliente")
 	OpenWithParm(wi_mant_clientes2,lstr_param)   
CASE 'pb_uso'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"uso")
 	OpenWithParm(wi_mant_almusos,lstr_param)   	 
CASE 'pb_estilo'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"estilo")
 	OpenWithParm(wi_mant_almestilos,lstr_param)   	 	 
CASE 'pb_coleccion'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"coleccion")
 	OpenWithParm(wi_mant_almcolecciones,lstr_param)   	 	 	 
CASE 'pb_color'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"color")
 	OpenWithParm(wi_mant_almcolores,lstr_param)   	 	 	 	 
CASE 'pb_familia'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"familia")
 	OpenWithParm(wi_mant_familias,lstr_param)   	 	 	 	 
CASE 'pb_subfamilia'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"subfamilia")
 	OpenWithParm(wi_mant_subfamilias,lstr_param)   	 	 	 	 
CASE 'pb_formato'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"formato")
 	OpenWithParm(wi_mant_formatos,lstr_param)   	 	 	 	 
CASE 'pb_subformato'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"subformato")
 	OpenWithParm(wi_mant_subformatos,lstr_param)   	 	 	 	 	 
CASE 'pb_cuenta'
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"empresa")
   lstr_param.s_argumentos[4]=GetItemString(This.GetRow(),"cuenta_contable")
   OpenWithParm(wi_mant_contaplan,lstr_param)  	
END CHOOSE






  










end event

event dw_1::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "unidad"
		valor_empresa = FALSE
      bus_titulo     = "VENTANA SELECCION DE TIPO DE UNIDADES "
 		bus_datawindow = "dw_ayuda_unidades"
   CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_proveedores_sector"
  	CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE CLIENTES"		 
	CASE "cuenta_contable"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
	CASE "empleado"
      bus_titulo     = "VENTANA SELECCION DE EMPLEADOS"
     	bus_datawindow = "dw_ayuda_empleados"
      bus_filtro     = "" 
	CASE "uso"
      bus_titulo     = "VENTANA SELECCION DE USOS"
     	bus_datawindow = "dw_ayuda_almusos"
      bus_filtro     = "" 		
	CASE "estilo"
      bus_titulo     = "VENTANA SELECCION DE ESTILOS"
     	bus_datawindow = "dw_ayuda_almestilos"
      bus_filtro     = "" 								
	CASE "coleccion"
      bus_titulo     = "VENTANA SELECCION DE COLECCIONES"
     	bus_datawindow = "dw_ayuda_almcolecciones"
      bus_filtro     = "" 								
	CASE "color"
      bus_titulo     = "VENTANA SELECCION DE COLOR"
     	bus_datawindow = "dw_ayuda_almcolores"
      bus_filtro     = "" 										
	CASE "familia"
      bus_titulo     = "VENTANA SELECCION DE FAMILIAS"
     	bus_datawindow = "dw_ayuda_familias"
      bus_filtro     = "" 										
	CASE "subfamilia"
      bus_titulo     = "VENTANA SELECCION DE SUBFAMILIAS"
     	bus_datawindow = "dw_ayuda_subfamilias"
      bus_filtro     = "" 										
	CASE "formato"
      bus_titulo     = "VENTANA SELECCION DE FORMATOS"
     	bus_datawindow = "dw_ayuda_formatos"
      bus_filtro     = "" 										
	CASE "subformato"
      bus_titulo     = "VENTANA SELECCION DE SUBFORMATOS"
     	bus_datawindow = "dw_ayuda_subformatos"
      bus_filtro     = "" 												
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;string uni_est,uni
uni     = This.GetItemString(row,"unidad")
uni_est = This.GetItemString(row,"unidad_est")
if isnull(uni_est) then uni_est = ""
 
if uni <>"" and uni_est="" then
	this.Setitem(row,"unidad_est",uni)
End if

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_articulos
integer x = 27
integer y = 184
integer width = 261
string text = "Artículo"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_articulos
integer x = 1765
integer y = 168
integer width = 347
integer height = 80
end type

event cb_insertar::clicked;string cliente
if dw_1.rowcount() > 0 then
	cliente = dw_1.object.cliente[dw_1.getrow()]
	if not isnull(cliente) then
		if trim(cliente) = "" then
			setnull(cliente)
		else
			cliente = trim(cliente)
		end if
		dw_1.object.cliente[dw_1.getrow()] = cliente
		dw_1.accepttext()
	end if
end if

CALL Super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_articulos
integer x = 2121
integer y = 168
integer width = 347
integer height = 80
end type

event cb_borrar::clicked;//Dec{0} cont
//Integer resp
//
//// antes de borrar el artículo hacemos una comprobación de la 
//// integridad referencial
//
//// almlinubica
//SELECT count(*)
//  INTO :cont
//  FROM almlinubica 
// WHERE almlinubica.empresa  = :codigo_empresa
//   AND almlinubica.articulo = :sle_valor.text;
//	
//if IsNull(cont) then cont = 0
//
//if cont > 0 then
//	resp = MessageBox("Borrado de un artículo","¡¡El artículo tiene stock en el almacén!! ¿Está seguro que desea dar de baja el artículo?",StopSign!,YesNo!,2)
//	if resp = 2 then return
//end if
//
//// venlifac
//SELECT count(*)
//  INTO :cont
//  FROM venlifac 
// WHERE venlifac.empresa  = :codigo_empresa
//   AND venlifac.articulo = :sle_valor.text;
//	
//if IsNull(cont) then cont = 0
//
//if cont > 0 then
//	resp = MessageBox("Borrado de un artículo","¡¡El artículo aparece en algunas líneas de factura!! ¿Está seguro que desea dar de baja el artículo?",StopSign!,YesNo!,2)
//	if resp = 2 then return
//end if
//
//// almmovhis
//SELECT count(*)
//  INTO :cont
//  FROM almmovhis 
// WHERE almmovhis.empresa  = :codigo_empresa
//   AND almmovhis.articulo = :sle_valor.text;
//	
//if IsNull(cont) then cont = 0
//
//if cont > 0 then
//	resp = MessageBox("Borrado de un artículo","¡¡El artículo tiene movimientos de stock!! ¿Está seguro que desea dar de baja el artículo?",StopSign!,YesNo!,2)
//	if resp = 2 then return
//end if
//
//Call super:: clicked
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_articulos
integer x = 293
integer y = 172
integer width = 567
integer height = 88
string displaydata = ""
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo      = "AYUDA SELECCION DE ARTICULOS"
ue_datawindow  = "dw_ayuda_articulos"
ue_filtro     = ""
isle_campo    = This

dw_calidades.Retrieve(codigo_empresa,sle_valor.text)
dw_cajas.Retrieve(codigo_empresa,sle_valor.text)
dw_pallets.Retrieve(codigo_empresa,sle_valor.text)


end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_articulos
integer x = 2478
integer y = 168
integer width = 347
integer height = 80
end type

event cb_salir::clicked;If insercion ="S" Then f_borrar_calidades()
Call Super::Clicked
end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_articulos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_articulos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_articulos
integer x = 73
integer y = 12
integer width = 2350
end type

type dw_proceso from datawindow within wi_mant_articulos
boolean visible = false
integer x = 5
integer width = 398
integer height = 184
boolean bringtotop = true
string dataobject = "dw_proceso_calformato"
boolean livescroll = true
end type

type dw_pallets from datawindow within wi_mant_articulos
event clicked pbm_dwnlbuttonclk
boolean visible = false
integer x = 1723
integer y = 1456
integer width = 1134
integer height = 280
boolean bringtotop = true
string dataobject = "dw_palarticulos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_objeto,codigo
str_parametros lstr_param

codigo=dw_1.getitemString(dw_1.getrow(),"codigo")

CHOOSE CASE f_objeto_datawindow(This)
   CASE 'pb_carpeta'
			lstr_param.s_titulo_ventana = "Mantenimiento de Pallets por Artículo y Caja"
			lstr_param.s_argumentos[2]  = string(codigo)
	      lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_palarticulo, lstr_param)
			dw_pallets.Retrieve(codigo_empresa,codigo,sle_valor.text)
END CHOOSE

end event

event doubleclicked;//if row=0 then Return
//
//String codpallet,articulo,clase
//codpallet = dw_pallets.GetItemString(dw_pallets.GetRow(),"codigo")
//articulo  = sle_valor.text
//integer bien=0,cuantos
//
//// Verifica si esta el tipo de pallet seleccionado
//
//  SELECT almartpallet.pallet  
//    INTO :codpallet
//    FROM almartpallet  
//   WHERE ( almartpallet.empresa  = :codigo_empresa ) AND  
//	      ( almartpallet.articulo = :articulo       ) AND  
//         ( almartpallet.pallet   = :codpallet      );
//
//
//IF SQLCA.SQLCode = 0 THEN
// 		DELETE FROM almartpallet
//      WHERE ( almartpallet.empresa  = :codigo_empresa ) AND  
//	         ( almartpallet.articulo = :articulo       ) AND  
//            ( almartpallet.pallet   = :codpallet      ) USING SQLCA;
//				IF SQLCA.SQLCode<>0 THEN  bien=1
//				IF bien=1 THEN
//						ROLLBACK USING SQLCA;
//						MessageBox("Problemas en la transaccion", &
//									  "No se puede Grabar El tipo de pallet", &
//										Exclamation!, Ok!, 2)
//					 ELSE
//						COMMIT USING SQLCA;
//			   END IF
//
//  ELSE
//	   // verifica si existe alguna linea al mismo tipo de pallet
//		clase = f_clase_pallets(codigo_empresa,codpallet)
//		
//		select count(*)
//		into :cuantos
//		from almartpallet
//		Where almartpallet.empresa       = :codigo_empresa
//		  and almartpallet.articulo      = :articulo
//		  and almartpallet.clase_pallet  = :clase;
//      
//		IF cuantos<> 0 THEN
//			   MessageBox("Problemas en la selección", &
//    			  "No se pueden grabar 2 del mismo tipo de pallet", &
//					Exclamation!, Ok!, 2)
//
// 		 else
//			INSERT INTO almartpallet
//					 ( empresa,articulo,pallet,clase_pallet)
//			VALUES ( :codigo_empresa,:articulo,:codpallet,:clase)
//					 using SQLCA;
//					 IF SQLCA.SQLCode<>0 THEN  bien=1
//					 
//					 IF bien=1 THEN
//							ROLLBACK USING SQLCA;
//							MessageBox("Problemas en la transaccion", &
//										  "No se puede Grabar El tipo de pallet", &
//											Exclamation!, Ok!, 2)
//						ELSE
//							COMMIT USING SQLCA;
//                END IF
//
//		End if
//End if
//	
//
//
//dw_pallets.Retrieve(codigo_empresa,sle_valor.text)
end event

type dw_calidades from datawindow within wi_mant_articulos
event clicked pbm_dwnlbuttonclk
boolean visible = false
integer x = 14
integer y = 1456
integer width = 768
integer height = 280
boolean bringtotop = true
string dataobject = "dw_articuloscal"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_objeto
str_parametros lstr_param

CHOOSE CASE f_objeto_datawindow(This)

   CASE 'pb_carpeta'

			lstr_param.s_titulo_ventana = "Mantenimiento de Calidades por Articulo"
			lstr_param.s_argumentos[2]  = sle_valor.Text
         lstr_param.i_nargumentos    = 2
         OpenWithParm(wi_mant_almartcal, lstr_param)
   		dw_calidades.Retrieve(codigo_empresa,sle_valor.Text)
END CHOOSE

end event

type st_4 from statictext within wi_mant_articulos
integer x = 864
integer y = 112
integer width = 114
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F6"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_1 from groupbox within wi_mant_articulos
integer x = 1751
integer y = 132
integer width = 1088
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_cajas from datawindow within wi_mant_articulos
boolean visible = false
integer x = 791
integer y = 1456
integer width = 933
integer height = 228
boolean bringtotop = true
string dataobject = "dw_articuloscaja"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_objeto
str_parametros lstr_param

CHOOSE CASE f_objeto_datawindow(This)

   CASE 'pb_carpeta'

			lstr_param.s_titulo_ventana = "Mantenimiento de Cajas por Artículo"
			lstr_param.s_argumentos[2]  = sle_valor.text
         lstr_param.i_nargumentos    = 2
         OpenWithParm(wi_mant_articulocaja, lstr_param)
   		dw_cajas.Retrieve(codigo_empresa,sle_valor.text)
END CHOOSE

end event

type dw_2 from datawindow within wi_mant_articulos
boolean visible = false
integer x = 1065
integer y = 88
integer width = 41
integer height = 36
integer taborder = 30
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within wi_mant_articulos
boolean visible = false
integer x = 2871
integer y = 176
integer width = 233
integer height = 68
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ren"
end type

event clicked;string sel,articulo
datastore ds
long cont

sel='select codigo from articulos'

//ds=f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, ds)

for cont=1 to ds.rowcount()
	articulo=ds.object.codigo[cont]
	
	update articulos
	set codigo=convert(char,:cont)
	where empresa=:codigo_empresa and
			codigo=:articulo;
			
	if sqlca.sqlcode<>0 then
		f_mensaje("Error","articulos")
		rollback;
		exit
	end if
	
	update almartcal
	set articulo=convert(char,:cont)
	where empresa=:codigo_empresa and
			articulo=:articulo;

	if sqlca.sqlcode<>0 then
		f_mensaje("Error","almartcal")
		rollback;
		exit
	end if			
	
	update almartcajas
	set articulo=convert(char,:cont)
	where empresa=:codigo_empresa and
			articulo=:articulo;
			
	if sqlca.sqlcode<>0 then
		f_mensaje("Error","almartcajas")
		rollback;
		exit
	end if	
	
	update palarticulo
	set articulo=convert(char,:cont)
	where empresa=:codigo_empresa and
			articulo=:articulo;
			
	if sqlca.sqlcode<>0 then
		f_mensaje("Error","palarticulos")
		rollback;
		exit
	end if			
next


destroy ds
end event

type pb_calculadora from u_calculadora within wi_mant_articulos
integer x = 864
integer y = 164
integer width = 114
integer height = 100
integer taborder = 11
boolean originalsize = false
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros

Select count(*) 
Into :registros 
From articulos
where empresa = :codigo_empresa;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,codigo)+1) 
   Into   :registros
   From   articulos
	where empresa = :codigo_empresa;
	sle_valor.text=string(registros)
END IF
dw_1.TriggerEvent("Clicked")
end event


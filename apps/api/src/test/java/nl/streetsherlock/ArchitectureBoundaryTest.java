package nl.streetsherlock;

import com.tngtech.archunit.core.importer.ImportOption;
import com.tngtech.archunit.junit.AnalyzeClasses;
import com.tngtech.archunit.junit.ArchTest;
import com.tngtech.archunit.lang.ArchRule;

import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.classes;
import static com.tngtech.archunit.library.Architectures.layeredArchitecture;

@AnalyzeClasses(packages = "nl.streetsherlock", importOptions = ImportOption.DoNotIncludeTests.class)
class ArchitectureBoundaryTest {

    @ArchTest
    static final ArchRule ARCH_MOD_001 =
            layeredArchitecture().consideringOnlyDependenciesInLayers()
                    .layer("Intake").definedBy("..intake..")
                    .layer("Incidents").definedBy("..incidents..")
                    .layer("Shared").definedBy("..shared..")
                    .whereLayer("Intake").mayNotBeAccessedByAnyLayer()
                    .whereLayer("Incidents").mayNotBeAccessedByAnyLayer();

    @ArchTest
    static final ArchRule ARCH_MOD_002 =
            classes().that().resideInAPackage("..intake..")
                    .should().onlyDependOnClassesThat()
                    .resideOutsideOfPackages("..incidents..", "..config..");

    @ArchTest
    static final ArchRule ARCH_MOD_003 =
            classes().that().resideInAPackage("..incidents..")
                    .should().onlyDependOnClassesThat()
                    .resideOutsideOfPackages("..intake..", "..config..");

    @ArchTest
    static final ArchRule ARCH_MOD_004 =
            classes().that().resideInAnyPackage("..intake..", "..incidents..", "..shared..")
                    .should().onlyBeAccessed().byAnyPackage(
                            "..intake..", "..incidents..", "..shared..", "nl.streetsherlock");
}
